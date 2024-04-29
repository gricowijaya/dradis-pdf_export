require_relative 'report_content'

module Dradis
  module Plugins
    module PdfExport

      class Processor < Prawn::Document
        def initialize(args={})
          super(top_margin: 70)

          content_service = args[:content_service]

          @author = 'Security Tester'
          @email  = 'tester@securitytesting.com'
          @issues = content_service.all_issues
          @notes  = content_service.all_notes
          @title  = "Dradis Framework - v#{Dradis::CE::VERSION::STRING}"

          sort_issues
        end

        def generate
          cover_page
          # project_notes
          # document_properties
          executive_summary
          summary_of_findings
          detailed_findings
          tool_list

          # outline
        end

        private
        def sort_issues
          sorted = { info: [], low: [], medium: [], high: []}
          @issues.each do |issue|
             cvss = issue.fields['CVSSv2'].to_f;
             case cvss
               when 0..0.9
                 sorted[:info] << issue
               when 1.0..3.9
                 sorted[:low] << issue
               when 4.0..6.9
                 sorted[:medium] << issue
               else
                 sorted[:high] << issue
             end
           end
           @sorted = sorted[:high] + sorted[:medium] + sorted[:low] + sorted[:info]
        end

        def cover_page
          move_down 50
          # change your logo here
          image "#{Engine.config.paths['app/assets'].expanded.first}/logo_pdf.jpg", position: :center
          move_down 20

          # put your client company name here
          text '<b><font size="24">PT XYZ</font></b>', inline_format: true, align: :center
          move_down 20
          # put your company name here
          text "MY COMPANY ABC", align: :center


          bounding_box([70, 150], width: 200, height: 150) do
            text "Address                                                www.website.com", inline_format: :true, align: :left
            text "Address 33333                                                              555-5555555", inline_format: :true, align: :left
            text "Country", inline_format: :true, align: :left

            # transparent(0.5) { stroke_bounds }  # This will stroke on one page
            #text "<b>Author</b>: #{@author}", inline_format: :true
            #text "<b>Email</b>: #{@email}", inline_format: :true
            #text "<b>Date</b>: #{Time.now.strftime('%Y-%m-%d')}", inline_format: :true
            # transparent(0.5) { stroke_bounds }  # And this will stroke on the next
          end
          start_new_page
        end

        def executive_summary 
				  report_content = ReportContent.new

          draw_header

          text 'Executive Summary'
          move_down 20
					text report_content.get_executive_intro 
					text report_content.get_executive_purpose 

          start_new_page
        end

        def project_notes
          draw_header

          text 'Project notes'
          move_down 20

          @notes.each do |note|
            fields = note.fields
            text "<b>#{fields['Title']}</b>", inline_format: true
            text fields['Description']
          end

          start_new_page
        end

        def document_properties
          draw_header

          text "Company", inline_format: true, align: :left
          text "Document Title", inline_format: true, align: :left
          text "Document Number", inline_format: true, align: :left
          text "Date  #{Time.now.strftime('%Y-%m-%d')}", inline_format: true, align: :left
          text "Classification", inline_format: true, align: :left
          text "Document Type", inline_format: true, align: :left

          recipient_data = [[ 'Name', 'Title', 'Company']]
          recipient_data << ['John Doe', 'Security Analyst', 'Security Testing Inc.']

          table recipient_data, header: true, position: :center
        end

        def summary_of_findings
          draw_header

          text '<b>SUMMARY OF FINDINGS<b>'
          move_down 20

          summary_of_findings_data = [['Title', 'CVSSv2']]

          @sorted.each do |note|
            fields = note.fields
            summary_of_findings_data << [fields['Title'], fields['CVSSv2']]
            #text "• #{fields['Title']} (#{fields['CVSSv2']})"
          end

          table summary_of_findings_data, header: true, position: :center

          start_new_page
        end

        def detailed_findings
          draw_header

          text '<b>DETAILED FINDINGS<b>'
          move_down 20

          #detailed_findings_data = [['Title', 'CVSSv2', 'Description']]

          @sorted.each do |note|
            fields = note.fields
            #detailed_findings_data << [fields['Title'], fields['CVSSv2'], fields['Description']]
            
            
            text "<b>#{fields['Title']}</b> - (#{fields['CVSSv2']})", inline_format: true
            move_down 20  
            text '<b>DESCRIPTION<b>'
            text fields['Description']

            move_down 20
            text '<b> SOLUTION <b>'
            text fields['Solution']
            #text "<b>Mitigation:</b>", inline_format: true
            #text fields['Mitigation']
            start_new_page
          end

          #table detailed_findings_data, header: true, position: :center
        end

        def tool_list
          draw_header

          text '<b>TOOLS USED<b>'
          move_down 20

          data = [
            ['Name', 'Description']
          ]

          data << ['Dradis Framework', "Collaboration and reporting framework\nhttp://dradisframework.org" ]
          data << ['TheHive', "SIEM Tools integrated with MISP\n https://thehive-project.org" ]

          table data, header: true, position: :center
        end

        def outline
          outline.define do
            section('Report Content', destination: 2) do
              page title: 'Summary of Findings', destination: 2
              page title: 'Tool List', destination: 3
            end
          end
        end

        def draw_header
          fill_color 'efefef'
          fill_rectangle [bounds.left-50, bounds.top + 100], bounds.width + 100, 87
          fill_color '00000'

          box = bounding_box [bounds.left-50, bounds.top+50], :width  => (bounds.width + 100) do

            font "Helvetica"
            text "Security Assessment Report", align: :center
            move_down 20

            stroke_color 'dadada'
            stroke_horizontal_rule
            stroke_color '000000'

          end
          move_down 40
        end

      end

      class Exporter < Dradis::Plugins::Export::Base
        def export()
          pdf = Processor.new(content_service: content_service)
          pdf.generate
          pdf
        end
      end
    end
  end
end
