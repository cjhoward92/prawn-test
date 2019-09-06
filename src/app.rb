require "fileutils"
require "prawn"

$TWIPS_PER_INCH = 72
$LETTER_WIDTH_INCHES = 8.5
$LETTER_HEIGHT_INCHES = 11
$LETTER_WIDTH_TWIPS = $TWIPS_PER_INCH * $LETTER_WIDTH_INCHES
$LETTER_HEIGHT_TWIPS = $TWIPS_PER_INCH * $LETTER_HEIGHT_INCHES

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
  if File.exists?(pdf_path) then
    puts "Deleting the PDF..."
    File.delete(pdf_path)
  end

  Prawn::Document.generate(pdf_path, :page_size => "LETTER", :margin => 0) do |pdf|
    pdf.text "Hello darkness my old friend"
    pdf.text "Again...."

    top_box_x = 0
    top_box_y = $LETTER_HEIGHT_TWIPS / 2
    pdf.bounding_box([top_box_x, top_box_y], :width => $LETTER_WIDTH_TWIPS / 2, :height => $LETTER_HEIGHT_TWIPS / 2) do
      pdf.text "I am in the box"
      pdf.stroke_color "FF0000"
      pdf.stroke_bounds
    end
  end
end

p = make_init_dir
make_pdf(p)
