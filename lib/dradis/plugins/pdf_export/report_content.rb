module Dradis
  module Plugins
    module PdfExport
			class ReportContent
				def initialize
					@executive_intro = "The purpose of this report is to provide an overview of the security assessment conducted on the PT XYZ network. The assessment was conducted by MY COMPANY ABC. The assessment was conducted on the PT XYZ network to identify vulnerabilities that could be exploited by an attacker. The assessment was conducted using a combination of automated and manual testing techniques. The assessment was conducted over a period of 5 days. The assessment was conducted by a team of 3 security professionals. The assessment was conducted using a combination of automated and manual testing techniques. The assessment was conducted over a period of 5 days. The assessment was conducted by a team of 3 security professionals."

					@executive_purpose = "The main purposes of this VAPT are:
• Perform targeted scans and manual investigation to validate vulnerabilities 
on their Web Apps, Mobile Apps, and Infrastructure.
• Attempt to exploit a vulnerability and provide a proof of concept against 
exploited vulnerability.
• Provide an impact overview of the security breach:
• Rank vulnerabilities based on the threat level, loss potential, and 
likelihood exploitation
• The confidentiality of the consumer information
• The integrity of the transaction data
• The availability of the Web Apps, Mobile Apps, and Infrastructure"

									end

				def get_executive_intro
					@executive_intro
				end

				def get_executive_purpose
					@executive_puspose
				end
			end
	  end
	end
end

