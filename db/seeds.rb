# frozen_string_literal: true

# USERS

papa = User.find_or_initialize_by(name: 'Manuel', lastname: 'Figueroa', email: 'papa@gmail.com')
unless papa.id
  papa.password = '12345678'
  papa.password_confirmation = '12345678'
  papa.save
end

mama = User.find_or_initialize_by(name: 'Irene', lastname: 'Alvarez', email: 'mama@gmail.com')
unless mama.id
  mama.password = '12345678'
  mama.password_confirmation = '12345678'
  mama.save
end

hija = User.find_or_initialize_by(name: 'Lucia', lastname: 'Figueroa', email: 'hija@gmail.com')
unless hija.id
  hija.password = '12345678'
  hija.password_confirmation = '12345678'
  hija.save
end

# ROLES

superadmin = Role.find_or_create_by(name: 'superadmin')
admin = Role.find_or_create_by(name: 'admin')
teller = Role.find_or_create_by(name: 'teller')

# UserRoles associations

papa.roles << superadmin unless papa.roles.include?(superadmin)
papa.roles << teller unless papa.roles.include?(teller)
hija.roles << admin unless hija.roles.include?(admin)

# TIMELINES

luciland = papa.created_timelines.find_or_create_by(title: 'LuciLand', protagonist: hija)
ivanyvienen = papa.created_timelines.find_or_create_by(title: 'Ivanyvienen')

# STORIES

papa.told_stories.find_or_create_by(title: 'Birhtday',
                                    date: Date.parse('24-06-2016'),
                                    protagonist: hija,
                                    teller_title: 'Papá',
                                    timeline: luciland,
                                    tags: %W[nacimiento cumplea\u00F1os dia_cero],
                                    description: "Lucía's Birhtday")
papa.told_stories.find_or_create_by(title: 'Birhtday',
                                    date: Date.parse('30-04-2018'),
                                    teller_title: 'Papá',
                                    timeline: ivanyvienen,
                                    tags: %W[cumple cumplea\u00F1os birthday],
                                    description: 'Ivan has arrived')

# TIMELINESTELLERS

# From Timeline
luciland.tellers << mama unless luciland.tellers.include?(mama)
ivanyvienen.tellers << mama unless luciland.tellers.include?(mama)
# From teller
papa.lines_as_teller << luciland unless papa.lines_as_teller.include?(luciland)
papa.lines_as_teller << ivanyvienen unless papa.lines_as_teller.include?(ivanyvienen)
