# frozen_string_literal: true

# USERS

papa = User.find_or_initialize_by(name: 'Manuel', lastname: 'Figueroa', email: 'papa@gmail.com')
unless papa.id
  papa.password = '12345678'
  papa.password_confirmation = '12345678'
  papa.save
end

hija = User.find_or_initialize_by(name: 'Lucia', lastname: 'Figueroa', email: 'hija@gmail.com')
unless hija.id
  hija.password = '12345678'
  hija.password_confirmation = '12345678'
  hija.save
end

# ROLES

superadmin = Role.find_or_create_by(name:'superadmin')
admin = Role.find_or_create_by(name:'admin')
teller = Role.find_or_create_by(name:'teller')

# UserRoles associations

papa.roles << superadmin unless papa.roles.include?(superadmin)
papa.roles << teller unless papa.roles.include?(teller)
hija.roles << admin unless hija.roles.include?(admin)

# TIMELINES

papa.created_timelines.find_or_create_by(title: 'LuciLand', protagonist: hija)
papa.created_timelines.find_or_create_by(title: 'IvanPasando')
