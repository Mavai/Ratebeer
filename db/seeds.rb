# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

Style.create name:'Lager'
Style.create name:'American IPA', description: "The American IPA is a different soul from the reincarnated IPA style. More flavorful than the withering English IPA, color can range from very pale golden to reddish amber. Hops are typically American with a big herbal and / or citric character, bitterness is high as well. Moderate to medium bodied with a balancing malt backbone."
Style.create name:'American Stout', description: 'Inspired from English & Irish Stouts, the American Stout is the ingenuous creation from that. Thankfully with lots of innovation and originality American brewers have taken this style to a new level. Whether it is highly hopping the brew or adding coffee or chocolate to complement the roasted flavors associated with this style. Some are even barrel aged in Bourbon or whiskey barrels. The hop bitterness range is quite wide but most are balanced. Many are just easy drinking session stouts as well. '


b1.beers.create name:"Iso 3", style_id: 1
b1.beers.create name:"Karhu", style_id: 1
b1.beers.create name:"Tuplahumala", style_id: 2
b2.beers.create name:"Huvila Pale Ale", style_id: 2
b2.beers.create name:"X Porter", style_id: 2
b3.beers.create name:"Hefeweizen", style_id: 3
b3.beers.create name:"Helles", style_id: 3

User.create username:"mavai", password:"Sala1", password_confirmation:"Sala1"
