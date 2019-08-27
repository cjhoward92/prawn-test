require "fileutils"
require "prawn"

def make_init_dir
  pdf_name = "test.pdf"
  root_dir = File.dirname("..")
  puts "Root dir: #{root_dir}"

  pdf_path = File.join(root_dir, "pdfs")
  puts "Pdf dir: #{pdf_path}"

  unless File.directory?(pdf_path) then
    FileUtils.mkdir_p(pdf_path)
  end

  pdf_path = File.join(pdf_path, pdf_name)
  puts "Pdf path: #{pdf_path}"

  pdf_path
end

def make_pdf(pdf_path)
  Prawn::Document.generate(pdf_path, :page_size => "LETTER") do |pdf|
    pdf.text "Hello there"
    pdf.text "Again...."
  end
end

p = make_init_dir
make_pdf(p)
