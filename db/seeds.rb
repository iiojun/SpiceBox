# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  username: 'iiojun',
  fullname: 'Jun IIO',
  password: '123456',
  role: 'member,admin')

Conference.create(
  name: 'The 1st Conference',
  description: 'This is the first event.',
  start_date: '2024-07-01',
  duration: 1)
c = Conference.create(
  name: 'The 2nd Conference',
  description: 'This is the second event.',
  start_date: '2025-08-15',
  duration: 2)
d1 = Day.create(
  title: 'The 1st Day',
  description: 'Premier jour',
  seq_no: 0)
c.days << d1
d2 = Day.create(
  title: 'The 2nd Day',
  description: 'Deuxième jour',
  seq_no: 1)
c.days << d2
t1 = Track.create(
  title: 'The A Track',
  description: 'The first day, the first track.',
  seq_no: 0)
d1.tracks << t1
t2 = Track.create(
  title: 'The B Track',
  description: 'The first day, the second track.',
  seq_no: 0)
d1.tracks << t2
s1 = Slot.create(
  title: 'The 1st Session',
  description: 'The first day, the first track, the first session.',
  chair: 'Prof. Jun IIO',
  room: '701',
  s_type: 'sequential',
  start_time: '2025-08-15 09:00:00',
  end_time: '2025-08-15 12:00:00')
t1.slots << s1
p1 = Presentation.create(
  title: 'The 1st Presentation',
  description: 'This is a great presentation by Mr. X.',
  authors: 'Foo Manchu, Mr. Spoch, Dr. Evil',
  presenter: 'Foo Manchu',
  evaluated: true,
  start_time: '2025-08-15 09:00:00',
  end_time: '2025-08-15 09:30:00')
s1.presentations << p1
p2 = Presentation.create(
  title: 'The 2nd Presentation',
  description: 'This is a great presentation by Mr. Y.',
  authors: 'Foo Manchu, Mr. Spoch, Dr. Evil',
  presenter: 'Mr. Spoch',
  evaluated: true,
  start_time: '2025-08-15 09:30:00',
  end_time: '2025-08-15 10:00:00')
s1.presentations << p2
p3 = Presentation.create(
  title: 'The 3rd Presentation',
  description: 'This is a great presentation by Mr. Z.',
  authors: 'Foo Manchu, Mr. Spoch, Dr. Evil',
  presenter: 'Shohei Ootani',
  evaluated: true,
  start_time: '2025-08-15 10:00:00',
  end_time: '2025-08-15 10:30:00')
s1.presentations << p3
s1 = Slot.create(
  title: 'Lunch Time',
  description: nil,
  start_time: '2025-08-15 12:00:00',
  end_time: '2025-08-15 13:00:00')
t1.slots << s1
s1 = Slot.create(
  title: 'The 2nd Session',
  description: 'The first day, the first track, the second session.',
  chair: 'Prof. Dare SORE',
  room: '701',
  s_type: 'parallel',
  start_time: '2025-08-15 13:00:00',
  end_time: '2025-08-15 15:00:00')
t1.slots << s1

