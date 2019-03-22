class Photo < ApplicationRecord
	 #Mounts paperclip image
	 has_attached_file :image
  	#This validates the type of file uploaded. According to this, only images are allowed.
  	#Validates file, file type and file size
  	validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  end
