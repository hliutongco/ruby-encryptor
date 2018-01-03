#To run this program, type the following into your terminal:
# e = FileEncryptor.new
# e.encrypt_file(filename, rotation)
# e.decrypt_file(filename, rotation)
# e.crack_file(filename)


class FileEncryptor

  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation.to_i)
    cipher_hash = Hash[characters.zip(rotated_characters)]
  end

  def encrypt_file(filename, rotation)
    #This File.open code opens the file and allows the program to read the file text
    file = File.open(filename, "r")
    file_text = file.read
    letters = file_text.split("")
    cipher = cipher(rotation)
    new_letters = letters.collect {|letter| cipher[letter]}

    puts "What would you like to name the output file?"
    new_filename = gets.chomp

    #This code uses the new_filename variable to create a new file
    #It then writes the encrypted text into the new file
    new_file = File.open(new_filename, "w")
    new_file.write(new_letters.join)
    new_file.close
  end

  def decrypt_file(filename,rotation)
    file = File.open(filename, "r")
    file_text = file.read
    letters = file_text.split("")
    cipher = cipher(rotation)
    new_letters = letters.collect {|letter| decrypt_letter(cipher,letter,rotation)}

    puts "What would you like to name the output file?"
    new_filename = gets.chomp

    new_file = File.open(new_filename, "w")
    new_file.write(new_letters.join)
    new_file.close
  end

  def decrypt_letter(cipher,letters,rotation)
    rotation = rotation.to_i
    index = cipher.keys.index(letters)
    index = index.to_i
    cipher.keys[index - rotation]
  end

  def crack_file(filename)
    file = File.open(filename, "r")
    file_text = file.read
    letters = file_text.split("")
    characters = (' '..'z').to_a
    counter = 0

    puts "What would you like to name the output file?"
    new_filename = gets.chomp
    new_file = File.open(new_filename, "w")

    characters.each_with_index do |val,index|
      cipher = cipher(index)
      new_letters = letters.collect {|letter| decrypt_letter(cipher,letter,index)}
      #This writes the decrypted code to the output file
      new_file.write("ROT-#{counter}: #{new_letters.join} \n")
      counter+=1
    end

    new_file.close
  end
end
