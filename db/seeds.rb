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

luciland = papa.created_timelines.find_or_create_by(title: 'LuciLand', protagonist: hija)
ivanYvienen = papa.created_timelines.find_or_create_by(title: 'IvanYvienen')


# STORIES

papa.told_stories.find_or_create_by(title: 'Birhtday',
                                    date: Date.parse('24-06-2016'),
                                    protagonist: hija,
                                    author_title: 'Papá',
                                    timeline: luciland,
                                    tags: ['nacimiento', 'cumpleaños', 'dia_cero'],
                                    description: "Lucía's Birhtday")
papa.told_stories.find_or_create_by(title: 'Birhtday',
                                    date: Date.parse('30-04-2018'),
                                    author_title: 'Papá',
                                    timeline: ivanYvienen,
                                    tags: ['cumple', 'cumpleaños', 'birthday'],
                                    description: "Ivan has arrived")

