class AdvancedEncryptor

  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation.to_i)
    cipher_hash = Hash[characters.zip(rotated_characters)]
  end

  def encrypt
    puts "What is your message?"
    message = gets.chomp
    letters = message.split("")
    puts "Enter a number between 1 and 90:"
    rotation_one = gets.chomp
    puts "Enter a second number between 1 and 90:"
    rotation_two = gets.chomp
    puts "Enter a third and final number between 1 and 90:"
    rotation_three = gets.chomp

    #This takes the user input and creates three different ciphers
    cipher_one = cipher(rotation_one)
    cipher_two = cipher(rotation_two)
    cipher_three = cipher(rotation_three)

    new_letters = []

    #If the letter's index number is a multiple of two, it is encrypted using cipher_one
    #If it's a multiple of three, it is encrypted with cipher_two
    #All other letters are encrypted with cipher_three
    #The letters are then shoveled into the new_letters array
    letters.each_with_index do |letter,index|
      if index % 2 == 0
        new_letters << cipher_one[letter]
      elsif index % 3 == 0
        new_letters << cipher_two[letter]
      else
        new_letters << cipher_three[letter]
      end
    end

    puts new_letters.join
  end
end

e = AdvancedEncryptor.new
e.encrypt
