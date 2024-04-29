module Dradis
  module Plugins
    module PdfExport
			class ReportContent
				def initialize
					@executive_text = "The purpose of this report is to provide an overview of the security assessment conducted on the PT XYZ network. The assessment was conducted by MY COMPANY ABC. The assessment was conducted on the PT XYZ network to identify vulnerabilities that could be exploited by an attacker. The assessment was conducted using a combination of automated and manual testing techniques. The assessment was conducted over a period of 5 days. The assessment was conducted by a team of 3 security professionals. The assessment was conducted using a combination of automated and manual testing techniques. The assessment was conducted over a period of 5 days. The assessment was conducted by a team of 3 security professionals."
				end

				def get_executive_text
					@executive_text
				end
			end
	  end
	end
end
