class EncryptorDecryptor

  def cipher(rotation)
    #Create an array containing the alphabet
    characters = (' '..'z').to_a

    #Create a new, rotated array using the rotation argument
    rotated_characters = characters.rotate(rotation.to_i)

    #Zip the above arrays together
    #Use the zipped arrays to make a hash
    cipher_hash = Hash[characters.zip(rotated_characters)]
  end

  def encrypt
    puts "ENCRYPT: What is your message?"
    message = gets.chomp

    #Cut message into individual characters
    letters = message.split("")

    puts "Define rotation (e.g. put 13 for ROT-13):"
    rotation = gets.chomp

    #Calls the cipher method and assigns the cipher hash to a variable
    cipher = cipher(rotation)

    #Encrypt the message letters using #encrypt_letter
    new_letters = letters.collect {|letter| cipher[letter]}

    #Join results back into one string
    puts new_letters.join
  end

  def decrypt
    puts "DECRYPT: What is your message?"
    message = gets.chomp
    letters = message.split("")
    puts "Define rotation (put N/A if unknown):"
    rotation = gets.chomp

    #The first block of this if statement cracks messages with an unknown rotation
    #First, it creates an array for all characters
    #Second, it iterates through the array and uses the index of each array element as a rotation number
    #It then outputs a list showing the result of every possible rotation
    if rotation == "N/A"
      characters = (' '..'z').to_a
      counter = 0
      characters.each_with_index do |val,index|
        cipher = cipher(index)
        new_letters = letters.collect {|letter| decrypt_letter(cipher,letter,index)}
        puts "ROT-#{counter}: #{new_letters.join}"
        counter+=1
      end
    else
      cipher = cipher(rotation)
      new_letters = letters.collect {|letter| decrypt_letter(cipher,letter,rotation)}
      puts new_letters.join
    end
  end

  def decrypt_letter(cipher,letter,rotation)
    rotation = rotation.to_i

    #First, it grabs the index number of the letter argument
    #Second, it subtracts the rotation from the index number
    #This essentially "undos" the encryption
    index = cipher.keys.index(letter)
    index = index.to_i
    cipher.keys[index - rotation]
  end
end

e = EncryptorDecryptor.new
e.encrypt
e.decrypt
