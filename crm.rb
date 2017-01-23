#linking file to contacts
require_relative 'contact'
require 'pry'

class CRM

  def initialize
    main_menu
  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number'
  end

  def call_option(user_selected)
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit
    end
  end

  def add_new_contact
    print 'Enter first name:'
    first_name = gets.chomp

    print 'Enter last name:'
    last_name = gets.chomp

    print 'Enter email address:'
    email = gets.chomp

    print 'Enter a note:'
    note = gets.chomp

    Contact.create(first_name, last_name, email, note)
  end

  def modify_existing_contact

    display_all_contacts
    puts 'Which ID contact would you like to modify?'
    id = gets.chomp.to_i
    modify_contact = Contact.find(id)
    # binding.pry

    print_attr_menu
    attri_selected = gets.to_i

    case attri_selected
      when 1 then puts 'Enter new first name'
        new_value = gets.chomp
        modify_contact.update(:first_name, new_value)
      when 2 then puts 'Enter new last name'
        new_value = gets.chomp
        modify_contact.update(:last_name, new_value)
      when 3 then puts 'Enter new email'
        new_value = gets.chomp
        modify_contact.update(:email, new_value)
      when 4 then puts 'Enter new note'
        new_value = gets.chomp
        modify_contact.update(:note, new_value)
    end

  end

  def delete_contact
    print_delete_menu
    delete_select = gets.chomp.to_i

    case delete_select
      when 1 then display_all_contacts
        puts 'Which ID contact would you like to delete?'
        id = gets.chomp.to_i
        remove_contact = Contact.find(id)
        remove_contact.delete

      when 2 then Contact.delete_all
    end
  end

  def display_all_contacts
    contact_list = Contact.all
    contact_list.each do |list|
      puts "#{list.full_name}"
    end
  end

  def search_by_attribute
    print_attr_menu
    option_attr = gets.chomp.to_i
    case option_attr
    when 1 then
      puts 'What is the first name?'
      attribute_value = gets.chomp
      option_name = Contact.find_by(:first_name, attribute_value)
      puts "You've selected #{option_name.first_name}"

    when 2 then
      puts 'What is the last name?'
      attribute_value = gets.chomp
      option_name = Contact.find_by(:last_name, attribute_value)
      puts "You've selected #{option_name.last_name}"

    when 3 then
      puts 'What is the email?'
      attribute_value = gets.chomp
      option_name = Contact.find_by(:email, attribute_value)
      puts "You've selected #{option_name.email}"

    when 4 then
      puts 'What is the note?'
      attribute_value = gets.chomp
      option_name = Contact.find_by(:note, attribute_value)
      puts "You've selected #{option_name.note}"


    end

  end

  def print_attr_menu
    puts '[1] First name'
    puts '[2] Last name'
    puts '[3] Email'
    puts '[4] Note'
  end

  def print_delete_menu
    puts '[1] Select a contact to delete'
    puts '[2] Delete all contacts'
  end

end
