semester = Semester.create( beginning: "Tue, 12 May 2015 6:00:00 -04:00" )

cameron = Dj.create(
  name: "Cameron", phone: "(734) 395-5779", email: "cbothner@umich.edu"
)

brandok = Dj.create(
  name: "Brandok", phone: "(555) 555-5555", email: "brandok@wcbn.org"
)

tyler = Dj.create(
  name: "Tyler C", phone: "(555) 555-5555", email: "tyler@wcbn.org"
)

dwb = Dj.create(
  name: "dwb", phone: "(734) 395-5793", email: "slowtrain@comcast.net"
)

surrealist = cameron.freeform_shows.build(
  name: "Ceci n’est pas Freeform",
  weekday: 1,
  beginning: "Tue, 12 May 2015 15:00:00 -04:00",
  ending: "Tue, 12 May 2015 17:30:00 -04:00"
)
surrealist.semester = semester
surrealist.save

bleached_meat = brandok.freeform_shows.build(
  name: "Bleached Meat",
  weekday: 1,
  beginning: "Tue, 12 May 2015 12:00:00 -04:00",
  ending: "Tue, 12 May 2015 15:00:00 -04:00"
)
bleached_meat.semester = semester
bleached_meat.save

disco = tyler.specialty_shows.build(
  name: "Drive Time Disco",
  weekday: 1,
  beginning: "Tue, 12 May 2015 17:30:00 -04:00",
  ending: "Tue, 12 May 2015 18:30:00 -04:00"
)
disco.semester = semester
disco.save

grey_matters = semester.talk_shows.build(
  name: "Grey Matters",
  weekday: 1,
  beginning: "Tue, 12 May 2015 18:30:00 -04:00",
  ending: "Tue, 12 May 2015 19:00:00 -04:00"
)
grey_matters.save

grey_matters.show_instances.create(
  beginning: "Mon 18 May 2015 18:30:00 -04:00",
  ending: "Mon 18 May 2015 19:00:00 -04:00"
)

six_oclock_shadow = semester.specialty_shows.create(
  name: "The Six O’Clock Shadow",
  weekday: 5,
  beginning: "Tue, 12 May 2015 18:00:00 -04:00",
  ending: "Tue, 12 May 2015 19:00:00 -04:00"
)
cameron.specialty_shows << six_oclock_shadow
brandok.specialty_shows << six_oclock_shadow

radiozilla = semester.specialty_shows.create(
  name: "Radiozilla",
  weekday: 0,
  beginning: "Tue, 12 May 2015 14:00:00 -04:00",
  ending: "Tue, 12 May 2015 15:00:00 -04:00"
)
cameron.specialty_shows << radiozilla

surr_first = surrealist.show_instances.create(
  beginning: "Mon, 18 May 2015 15:00:00 -04:00",
  ending: "Mon, 18 May 2015 17:30:00 -04:00"
)

bm_first = bleached_meat.show_instances.create(
  beginning: "Mon, 18 May 2015 12:00:00 -04:00",
  ending: "Mon, 18 May 2015 15:00:00 -04:00"
)
bm_first.dj = dwb
bm_first.save

disco_first = tyler.show_instances.build(
  beginning: "Mon, 18 May 2015 17:30:00 -04:00",
  ending: "Mon, 18 May 2015 18:30:00 -04:00"
)
disco.show_instances << disco_first
disco.save
disco_first.save

surr_first.songs.create([{
  artist: "Toro y Moi", name: "Lilly", album: "What For?", label: "Carpark",
  year: 2015, request: false, at: "Mon 18 May 2015 15:03:40 -04:00"
},{
  artist: "Qrion", name: "Only", album: "Ssh#ffb6c1", label: "Secret Songs",
  year: 2014, request: false, at: "Mon 18 May 2015 15:08:14 -04:00"
},{
  artist: "Best Coast", name: "In My Eyes", album: "California Nights",
  label: "Harvest", year: 2015, request: false,
  at: "Mon 18 May 2015 15:11:57 -04:00"
},{
  artist: "Hiatus Kaiyote", name: "Molasses", album: "Choose Your Weapon",
  label: "Flying Buddha", year: 2015, request: false,
  at: "Mon 18 May 2015 15:15:05 -04:00"
},{
  artist: "Stealing Sheep", name: "Deadlock", album: "Not Real",
  label: "Heavenly", year: 2015, request: false,
  at: "Mon 18 May 2015 15:21:37 -04:00"
},{
  artist: "Rongetz Foundation", name: "Such a Morning Person", album: "Kiss Kiss Double Jab",
  label: "Heavenly Sweetness", year: 2015, request: false,
  at: "Mon 18 May 2015 15:23:48 -04:00"
},{
  artist: "Chui Wan", name: "Beijing is Sinking (feat. Li Jianhong)", album: "Chui Wan",
  label: "Maybe Mars", year: 2015, request: false,
  at: "Mon 18 May 2015 15:30:51 -04:00"
},{
  artist: "Lower Dens", name: "Your Heart Is Still Beating", album: "Escape from Evil",
  label: "Ribbon", year: 2015, request: false,
  at: "Mon 18 May 2015 15:37:51 -04:00"
},{
  artist: "Mew", name: "Witness", album: "+-",
  label: "Play It Again Sam", year: 2015, request: false,
  at: "Mon 18 May 2015 15:43:36 -04:00"
},{
  artist: "The Very Best", name: "Sweka", album: "Makes a King/Machokela Mafumu",
  label: "Moshimoshi", year: 2015, request: false,
  at: "Mon 18 May 2015 15:47:30 -04:00"
},{
  artist: "Squarepusher", name: "Exjag Nives", album: "Damogen Furies",
  label: "Warp", year: 2015, request: false,
  at: "Mon 18 May 2015 15:54:14 -04:00"
},{
  artist: "Vessels", name: "Glass Lake", album: "Dilate",
  label: "Bias", year: 2015, request: false,
  at: "Mon 18 May 2015 15:56:50 -04:00"
},{
  artist: "Heroes of the Dancefloor", name: "I Could Never Get Involved", album: "Shelter",
  label: "Self-Released", year: 2014, request: false,
  at: "Mon 18 May 2015 16:03:58 -04:00"
}])

#surr_first.songs.create([{
  #name: "Sons and Daughters", artist: "The Decemberists",
  #album: "The Crane Wife", label: "Capitol", year: 2006, request: false,
  #at: "Mon, 18 May 2015 15:01:00 -04:00"
#},{
  #name: "Funkadelic", artist: "Maggot Brain", album: "Maggot Brain",
  #label: "Westbound", year: 1971, request: false,
  #at: "Mon, 18 May 2015 15:06:00 -04:00"
#},{
  #name: "Dear Prudence", artist: "The Beatles",
  #album: "The Beatles (White Album)", label: "Apple", year: 1968,
  #request: false, at: "Mon, 18 May 2015 15:14:00 -04:00"
#},{
  #name: "The Nights of Wine and Roses", artist: "Japandroids",
  #album: "Celebration Rock", label: "Polyvinyl", year: 2012, request: false,
  #at: "Mon, 18 May 2015 15:18:00 -04:00"
#},{
  #name: "Oliver James", artist: "Fleet Foxes", album: "Fleet Foxes",
  #label: "Sub Pop", year: 2008, request: true,
  #at: "Mon, 18 May 2015 15:22:00 -04:00"
#}])

bm_first.songs.create([{
  name: "Alone Again", artist: "The King Khan & BBQ Show",
  album: "Bad News Boys", label: "In The Red", year: 2005,
  request: false, at: "Mon, 18 May 2015 14:55:00 -04:00"
},{
  name: "Autodidactic", artist: "Swervedriver",
  album: "I Wasn't Born To Lose You", label: "Cobraside", year: 2015,
  request: true, at: "Mon, 18 May 2015 14:25:00 -04:00"
}])

legal_id = Signoff.create(
  on: "Legal ID",
  times: 7.times.map do |wday|
    24.times.map do |hr|
      {weekday: wday, at: Time.parse("Tue, 12 May 2015 #{hr}:00:01 -04:00")}
    end
  end.flatten
)

legal_id.signoff_instances.create([{
  on: "Legal ID",
  signed: "Brandon Kierdorf",
  at: "Mon, 18 May 2015 14:00:01 -04:00"
},{
  on: "Legal ID",
  signed: "Cameron Bothner",
  at: "Mon, 18 May 2015 15:00:01 -04:00"
}])

16.upto(20) do |i|
  legal_id.signoff_instances.create(
    on: "Legal ID",
    signed: nil,
    at: "Mon, 18 May 2015 #{i}:00:01 -04:00"
  )
end

events_info = Signoff.create(
  on: "Events Information",
  times: 7.times.map do |wday|
    [1,4,7,10,13,16,20].map do |hr|
      {weekday: wday, at: Time.parse("Tue, 12 May 2015 #{hr}:30:00 -04:00")}
    end
  end
)
concert_info = Signoff.create(
  on: "Concert Information",
  times: 7.times.map do |wday|
    [2,5,8,11,14,17,21,23].map do |hr|
      {weekday: wday, at: Time.parse("Tue, 12 May 2015 #{hr}:30:00 -04:00")}
    end
  end
)

concert_info.signoff_instances.create([{
  on: "Concert Information",
  signed: "Brandon Kierdorf",
  at: "Mon, 18 May 2015 14:30:00 -04:00"
}])
events_info.signoff_instances.create([{
  on: "Events Information",
  signed: nil,
  at: "Mon, 18 May 2015 16:30:00 -04:00"
}])
