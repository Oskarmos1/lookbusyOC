import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_typing_indicator/flutter_typing_indicator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'emails.dart';

class Messenger extends StatefulWidget {
  const Messenger({super.key});

  @override
  State<Messenger> createState() => _MessengerState();
}

class _MessengerState extends State<Messenger> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("I happened");
  }

  void newAd() {
    NativeAd? nativeAd;
    nativeAd = NativeAd(
      customOptions: {},
      adUnitId: "ca-app-pub-3940256099942544/1044960115",
      factoryId: "listTile",
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            convo.add([ad, false, true]);
          });
        },
        onAdFailedToLoad: (ad, error) {
          print("Ad failed to load $error");
          ad.dispose();
        },
      ),
      request: AdRequest(),
    );
    nativeAd.load();
  }

  Random rnd = Random();
  bool userInteraction = false;
  List<List<dynamic>> convo = [];
  String randomName = "Contact Name";
  List<String> videoPrompt = [
    "Hey, we’ve got something cool for you—check out this video!",
    "This one's just for you. Hit play and enjoy!",
    "You’re going to love this video—give it a watch!",
    "Take a break and watch this awesome video we’ve found for you.",
    "We thought you’d enjoy this—tap to watch!",
    "Here’s something fun for you to check out! Watch the video.",
    "Got a minute? Watch this quick video we think you'll like.",
    "Press play, you won’t want to miss this one!",
    "We picked this video just for you—enjoy!",
    "Feeling bored? Here’s a video to brighten your day.",
    "We found a video that’s right up your alley. Take a look!",
    "You deserve a break—sit back and watch this video.",
    "Here’s something we think you’ll really enjoy. Watch now!",
    "Ready for something cool? Check out this video.",
    "We’ve got a surprise for you—watch this video!",
    "Thought you might like this! Hit play and see for yourself.",
    "This video is worth your time—trust us, watch it!",
    "Need a little entertainment? Watch this video we found!",
    "We found something amazing—tap to watch the video now!",
    "Take a moment and enjoy this video we handpicked for you."
  ];
  List<String> questions = [
    "What’s ur fav way to spend a weekend?",
    "If u could travel anywhere, where would ya go?",
    "What’s a book that changed ur perspective?",
    "Do ya prefer coffee or tea? Why?",
    "What’s ur go-to comfort food?",
    "If u could have dinner with any historical figure, who would it be?",
    "What’s a hobby u’ve always wanted to try?",
    "How do u chill after a long day?",
    "What’s the best advice u’ve ever gotten?",
    "If u could relive any moment, what would it be?",
    "What’s something u can’t live without?",
    "Do u believe in fate or free will?",
    "What’s ur fav movie genre?",
    "What’s a skill u’d like to master?",
    "How do u stay motivated when feelin down?",
    "What’s the last song u listened to on repeat?",
    "If u had to describe urself in 3 words, what would they be?",
    "What’s ur fav childhood memory?",
    "How do u like to celebrate ur b-day?",
    "What’s a tradition that’s important to u?",
    "If u could only eat one type of cuisine, what would it be?",
    "What’s ur biggest fear?",
    "If u could switch lives with anyone for a day, who would it be?",
    "What’s a goal u’re workin towards?",
    "How do u define success?",
    "What’s ur fav way to stay active?",
    "Do u prefer to plan things or be spontaneous?",
    "What’s ur dream job?",
    "How do u deal with stress?",
    "What’s the last thing that made u laugh?",
    "What’s something u’re super passionate about?",
    "If u could have any superpower, what would it be?",
    "What’s ur fav season, and why?",
    "What’s ur biggest pet peeve?",
    "If u could learn any language, which would it be?",
    "What’s a movie that made u cry?",
    "Do u have a lucky number? What is it?",
    "What’s a place u’ve always wanted to visit?",
    "What’s ur fav way to relax?",
    "If u could change one thing about the world, what would it be?",
    "What’s ur fav ice cream flavor?",
    "Do u believe in aliens?",
    "What’s the most adventurous thing u’ve ever done?",
    "What’s ur fav way to express creativity?",
    "If u could time travel, would u go to the past or future?",
    "What’s a quote that inspires u?",
    "What’s the best concert u’ve ever been to?",
    "If u could own any animal as a pet, what would it be?",
    "What’s ur fav holiday and why?",
    "Do u have a hidden talent?",
    "What’s something that always makes u smile?",
    "If u could meet any celebrity, who would it be?",
    "What’s ur fav thing to do outdoors?",
    "What’s a challenge u’ve overcome?",
    "How do u stay organized?",
    "What’s the best gift u’ve ever received?",
    "What’s ur fav thing about urself?",
    "If u could only watch one TV show for the rest of ur life, what would it be?",
    "What’s a song that always lifts ur mood?",
    "How do u like to start ur day?",
    "What’s a fear u’ve conquered?",
    "What’s ur fav thing to do with friends?",
    "If u had to live in a different country, where would it be?",
    "What’s ur go-to karaoke song?",
    "What’s a dream u hope to achieve?",
    "If u could have dinner with any fictional character, who would it be?",
    "What’s ur fav type of weather?",
    "What’s a habit u’d like to break?",
    "How do u handle disagreements with friends?",
    "What’s the best piece of advice u’d give to someone?",
    "What’s a trend u wish would come back?",
    "If u could instantly learn a skill, what would it be?",
    "What’s ur fav thing to do on a rainy day?",
    "What’s a subject u were passionate about in school?",
    "How do u feel about social media?",
    "What’s a movie u can watch over and over?",
    "What’s ur idea of a perfect date?",
    "What’s a cause u care about deeply?",
    "If u could be any age for a week, what age would u choose?",
    "What’s ur fav snack?",
    "How do u like to celebrate holidays?",
    "What’s something u wish u knew more about?",
    "What’s the most important quality in a friend?",
    "If u could give a younger version of urself advice, what would it be?",
    "What’s a skill u think everyone should have?",
    "What’s ur fav way to stay connected with friends?",
    "What’s the best compliment u’ve ever received?",
    "How do u handle stress in tough times?"
  ];
  List<String> response = [
    "Sounds good!",
    "I agree!",
    "That makes sense.",
    "Absolutely!",
    "I see what you mean.",
    "Good point!",
    "I like that idea!",
    "Sure thing!",
    "Got it!",
    "Thanks for sharing!",
    "I’m on it!",
    "That works for me.",
    "I’m interested!",
    "I understand.",
    "I’ll think about it.",
    "I appreciate that.",
    "Let’s do it!",
    "Count me in!",
    "I’ll let you know.",
    "I’m here for it!",
    "That’s a great suggestion!",
    "I’ll check it out.",
    "That sounds fun!",
    "I’m all for it!",
    "Sounds like a plan!",
    "Thanks for the update!",
    "I’m excited about that!",
    "I’ll get back to you soon.",
    "That’s a good idea!",
    "I’m with you on that.",
    "Thanks for letting me know!",
    "I’ll keep that in mind.",
    "I’m looking forward to it!",
    "Let’s make it happen!",
    "I appreciate your help.",
    "Thanks for the info!",
    "Sounds like a great plan!",
    "I’ll follow up with you.",
    "I’m in!",
    "That’s really helpful!",
    "I’m ready for it!",
    "Let’s stay in touch.",
    "I’ll update you later.",
    "I understand your concerns.",
    "Thanks for your patience!",
    "I appreciate your feedback.",
    "I’m excited to see how this goes!",
    "Let me know if you need anything.",
    "I’ll take care of it.",
    "Let’s catch up later!",
    "That sounds promising!",
    "I’ll confirm that.",
    "I appreciate your support.",
    "I’ll be there!",
    "Thanks for your input!",
    "I’m ready to collaborate!",
    "I’m grateful for your assistance.",
    "I’ll keep you posted!",
    "Sounds like a good idea!",
    "Let’s touch base again soon.",
    "I’m thrilled about that!",
    "I’ll take a look at it.",
    "Thanks for bringing that up!",
    "I’m okay with that.",
    "That’s a wise choice!",
    "Let’s get started!",
    "I’ll make it happen.",
    "Thanks for your understanding!",
    "I’ll make a note of that.",
    "I’ll remember that!",
    "Thanks for your insight!",
    "I’m all in!",
    "That’s an interesting perspective!",
    "I’ll keep that on my radar.",
    "Let’s proceed with that.",
    "I’m open to that!",
    "Thanks for reaching out!",
    "I’ll give it a shot!",
    "That’s a valid point!",
    "I’m here if you need me!",
    "I’ll check back in with you.",
    "I’m glad you mentioned that!",
    "That sounds like a great opportunity!",
    "I’m keen to learn more!",
    "Let’s make it work!",
    "Thanks for considering me!",
    "I appreciate you thinking of me.",
    "I’ll see what I can do.",
    "Let’s find a time to chat!",
    "I’ll reach out to you later.",
    "I’ll get on that right away.",
    "Let’s keep the momentum going!",
    "I’m excited to collaborate!",
    "Thanks for your suggestion!",
    "I’ll support that decision.",
    "I’m thankful for your help!",
    "I’ll get back to you shortly.",
    "That’s a great takeaway!",
    "I’ll look into it!",
    "I appreciate your thoughts!",
    "That’s a creative solution!",
    "I’m glad we’re on the same page!",
    "Let’s regroup later.",
    "Thanks for the heads up!",
    "I’ll figure it out!",
    "Chillin' at home, binge-watching shows.",
    "Totally wanna hit up Japan, it’s on my bucket list!",
    "That one book about mindset, changed everything.",
    "Coffee all day! Tea's cool but I need that caffeine.",
    "Pizza and ice cream, can’t go wrong!",
    "Definitely would love to have dinner with Cleopatra!",
    "I wanna try painting or something artsy.",
    "I just kick back with some music or a movie.",
    "Just keep it simple: be yourself.",
    "Reliving my last birthday party would be epic!",
    "My phone, can't live without it!",
    "I believe in free will, we make our own paths.",
    "Action flicks all the way!",
    "Guitar skills for sure, it’s so cool.",
    "Just push through it and stay focused.",
    "Last song? Probably something by Dua Lipa.",
    "Creative, chill, and loyal.",
    "Playing outside with my friends, good times.",
    "I love having a low-key dinner with fam.",
    "Family dinners during the holidays are the best!",
    "Definitely Italian food, it’s my fave.",
    "Spiders freak me out, no thanks!",
    "I’d switch with Elon Musk for a day, just for the fun!",
    "Finishing my degree is a big one for me.",
    "Success is just being happy with what u got.",
    "Hiking, it’s such a vibe!",
    "I like a bit of both, depends on the mood.",
    "Tech stuff sounds cool, maybe gaming?",
    "Stress? I just binge-watch some shows.",
    "That funny TikTok I saw the other day.",
    "Anything about space! It’s so fascinating.",
    "Super speed would be awesome!",
    "Fall is the best—pumpkin spice, cozy vibes!",
    "People chewing loudly, drives me nuts!",
    "Spanish, it's such a beautiful language.",
    "The Notebook always gets me.",
    "7, it’s just always been my lucky number.",
    "Greece has been on my list forever!",
    "Just chillin' with a good book.",
    "World peace, I mean, who wouldn’t want that?",
    "Chocolate chip cookie dough, no contest.",
    "For sure, there’s gotta be something out there!",
    "Skydiving was a rush, would do it again!",
    "I love sketching, it’s super relaxing.",
    "Time travel to the future, always curious!",
    "‘You miss 100% of the shots you don’t take.’",
    "Beyoncé's concert was lit!",
    "A dragon would be epic to have as a pet!",
    "Christmas is the best, family and food!",
    "Yeah, I can juggle a bit, it’s fun.",
    "A cute puppy always makes me smile!",
    "Definitely would love to meet Tom Holland!",
    "Hiking or just chillin' at the beach.",
    "I once climbed a mountain—super proud of that!",
    "I use my planner, keeps me on track.",
    "That gift my bestie got me for my b-day, loved it!",
    "I love my sense of humor, it keeps things light.",
    "Friends is my all-time fave, can’t get enough!",
    "‘Happy’ by Pharrell, always brightens my day.",
    "Coffee and a good breakfast to kickstart the day.",
    "Overcoming my fear of public speaking was huge.",
    "Just hanging out at a café is perfect.",
    "I’d love to live in New Zealand, it’s stunning!",
    "‘Livin’ on a Prayer’ is my jam for sure!",
    "Becoming a writer is def on my list.",
    "Talking to my fam over dinner is the best.",
    "I wish I knew more about psychology.",
    "Loyalty is everything in a friendship.",
    "Just believe in yourself, don’t doubt it.",
    "Basic cooking skills, everyone should know!",
    "Group chats keep me connected, love it!",
    "When someone says I inspire them, it hits hard.",
    "I just take deep breaths and find my center."
  ];
  List<String> longerTexts = [
    "Hey! Just checking in to see how you’re doing. It’s been a while since we last talked, and I’d love to catch up. Let me know if you’re free to chat sometime soon!",
    "I was thinking about our last conversation, and it really inspired me to take action on some things I’ve been putting off. Thanks for always being so encouraging!",
    "I just wanted to share a quick update on my project. I made some progress and can’t wait to show you what I’ve done! I really value your opinion, so let’s connect soon.",
    "I hope you’re having a great day! I’ve been trying out some new recipes lately and would love to share them with you. Cooking has become a fun escape for me.",
    "I just finished a really good book that I think you’d enjoy! It’s a great mix of adventure and mystery, and I couldn’t put it down. Let’s chat about it when you have time!",
    "I had a fantastic weekend exploring the city! I visited some new places and tried some delicious food. I can’t wait to tell you all about it!",
    "I wanted to reach out to see how you’re feeling about everything going on right now. It can be overwhelming, and I’m here if you need someone to talk to or vent to.",
    "Just wanted to remind you about our meeting next week. I think it’ll be a great opportunity for us to brainstorm some ideas and get things moving forward.",
    "I’ve been reflecting on some goals for this year, and I’d love to hear about yours. I think we can motivate each other to stay on track and achieve what we want.",
    "How’s everything going on your end? I’ve been busy with work but would love to make some time to catch up. It’s always nice to hear what’s new with you!",
    "I just got back from a trip, and it was amazing! I experienced so many new things and took lots of pictures. Can’t wait to share them with you and hear your thoughts!",
    "I saw something that reminded me of you today, and it made me smile. It’s always nice to have those little reminders of good friends in our lives.",
    "I hope you’re doing well! I’ve been meaning to ask if you’d like to join me for a workout session sometime. It could be a fun way to catch up while staying active!",
    "I’m really looking forward to the event next month! It’ll be a great chance to connect with others and share ideas. Let’s plan to go together if you’re up for it!",
    "I just wanted to send a little encouragement your way. I know things have been tough lately, but remember you’re stronger than you think and you’ve got this!",
    "I’ve been working on some personal projects and it’s been a rewarding experience. I’d love to hear what you’ve been up to and any projects you’re working on as well.",
    "I was reminiscing about our last adventure together and it made me realize how much I miss those moments. We should plan another outing soon, just like old times!",
    "I wanted to share a podcast episode that I found really insightful. It discusses some interesting ideas that I think you would appreciate. Let me know if you check it out!",
    "I had a really productive week and got a lot done on my to-do list. It feels great to make progress! I’d love to hear how your week has been going.",
    "I’m planning a little gathering soon and would love for you to come! It’s been too long since we all got together, and it would be great to catch up in person.",
    "I’ve been trying to practice mindfulness lately, and it’s been quite a journey. If you’re interested, I’d love to share some tips and techniques that have worked for me.",
    "I recently discovered a new hobby that I’m really enjoying! It’s nice to find something new to immerse myself in. What about you? Have you picked up any new interests?",
    "I wanted to see if you’d like to collaborate on a project together. I think we could create something really special with our combined skills and ideas.",
    "I hope you’re having a lovely week! If you need a break, let’s grab coffee or tea soon. It would be nice to relax and chat about everything going on in our lives.",
    "I can’t believe how quickly this year is flying by! It feels like just yesterday we were making resolutions. What are some of the things you hope to accomplish this year?",
    "I just wanted to drop a note to say I appreciate you. You always know how to lift my spirits, and I’m grateful for your friendship.",
    "I’ve been thinking about doing a little road trip soon. It would be fun to explore some new places. If you’re interested, let’s plan a trip together!",
    "I’ve been diving into some new music lately, and it’s been refreshing. I’d love to hear what you’re listening to these days!",
    "I wanted to share some exciting news! I just received an opportunity that I’ve been working towards, and I can’t wait to see where it leads. Your support has been invaluable!",
    "I’ve started a new routine, and it’s making a big difference in my day-to-day life. If you’re looking for a change, I’d love to share what’s been working for me.",
    "I hope you’re doing well! I’ve been meaning to ask if you’d like to start a book club together. It could be a fun way to discuss our favorite reads!",
    "I’ve been enjoying some quiet time lately, and it’s been really refreshing. It’s nice to step back and just take a moment for myself every now and then.",
    "I just wanted to check in and see how things are going with you. Life can get hectic, and it’s important to stay connected, so let’s make some time to chat soon!",
    "I recently tried a new restaurant, and it was amazing! We should go together sometime. I know you’d love the food there.",
    "I wanted to share a funny story that happened to me recently. It definitely brightened my day, and I think it’ll give you a good laugh too!",
    "I’m looking forward to the upcoming holiday! It’s always nice to spend time with friends and family. Do you have any special plans?",
    "I’ve been working on improving my photography skills. It’s been a fun challenge! If you’re interested, I’d love to share some tips or even go on a photo walk together.",
    "I can’t wait to hear all about your recent adventures! You always have the best stories to share. Let’s get together soon so you can fill me in.",
    "I wanted to check in and see how you’re feeling about everything happening in the world right now. It’s a lot to process, and I’m here to listen if you need to talk.",
    "I’ve been trying to focus on gratitude lately, and it’s amazing how much it shifts my perspective. If you’re interested, I’d love to chat about it sometime!",
    "I’m planning a game night soon and would love for you to come! It’ll be a fun way to unwind and enjoy each other’s company.",
    "I wanted to share a little motivation with you. Remember that every small step counts, and you’re doing great! Keep pushing towards your goals.",
    "I hope you’re having a wonderful day! If you’re looking for something fun to do, I’d love to plan a little outing together. Let me know what sounds good!",
    "I’ve been listening to some really inspiring TED talks recently. If you’re interested, I can send you some recommendations!",
    "I just wanted to remind you how much I appreciate our friendship. You always bring positivity into my life, and I’m grateful for you!",
    "I’ve been thinking about trying a new workout class. If you’re up for it, let’s sign up together and motivate each other!",
    "I recently started journaling, and it’s been such a beneficial practice for me. If you’re curious, I’d love to share some insights!",
    "I wanted to let you know that I’m here for you, no matter what. Life can throw a lot our way, but having support makes all the difference.",
    "I hope your week is going well! Let’s make plans to catch up soon. I’ve missed our chats!",
    "I’ve been exploring some new podcasts, and I’d love to share my favorites with you. It’s always fun to discover new things together!",
    "I wanted to share a beautiful sunset I captured recently. Nature has a way of bringing peace and inspiration, doesn’t it?",
    "I’ve been enjoying some quiet time lately and reflecting on life. It’s amazing how much clarity can come from just slowing down for a moment.",
    "I wanted to see if you’d like to join me for a hike this weekend. It would be great to get some fresh air and enjoy nature together!",
    "I just finished a really intense series on Netflix and am still reeling from it. What are you currently watching? I’d love some recommendations!",
    "I hope you’re doing well! Let’s plan a movie night soon; it’s been too long since we’ve had a good laugh together.",
    "I wanted to let you know that I believe in you. Whatever challenges you’re facing, you’ve got the strength to overcome them!",
    "I’ve been working on my personal development goals, and it feels great to make progress. If you want to share yours, I’m all ears!",
    "I hope your day is going smoothly! Just wanted to reach out and remind you that you’re doing an amazing job. Keep it up!",
    "I wanted to see if you’d like to collaborate on something creative together. I think it could be a lot of fun and a great way to express ourselves!",
    "I’ve been enjoying my time outdoors lately. Nature has a wonderful way of lifting our spirits. Let’s plan a day out in the sun soon!",
    "I just discovered a new cafe that has the best pastries! We should go try it out together sometime; I know you love a good treat.",
    "I wanted to share some exciting news with you! I finally accomplished a goal I’ve been working towards for a while. Your support has meant the world to me!",
    "I hope you’re having a fantastic week! If you ever need someone to talk to or vent to, I’m always here for you.",
    "I wanted to send a little reminder that you’re not alone in this journey. We’re in this together, and I’m just a message away!",
    "I recently attended a workshop that inspired me in so many ways. I’d love to tell you all about it when we catch up next!",
    "I just wanted to take a moment to say how grateful I am for our friendship. You bring so much positivity into my life, and I truly appreciate you!",
    "I’ve been enjoying some quiet evenings lately, just reflecting and relaxing. It’s nice to take a step back every once in a while.",
    "I wanted to reach out and see how you’re doing. It’s important to check in with each other, especially during busy times.",
    "I’ve been listening to some incredible audiobooks recently. If you’re interested, I can send you my favorites!",
    "I wanted to share a little bit of motivation with you today: Remember that progress, no matter how small, is still progress. Keep moving forward!",
    "I hope you’re having a lovely day! If you’re ever in need of a pick-me-up, just let me know. I’m here for you!",
    "Honestly, I just love chilling at home, maybe binge-watching some Netflix shows or playing video games with friends. It’s the best way to recharge after a hectic week.",
    "If I could travel anywhere, I’d totally pick Japan. The culture, food, and just the vibe there seem amazing. Plus, I wanna see cherry blossoms in person!",
    "There’s this book called 'Mindset' by Carol Dweck that really opened my eyes. It talks about having a growth mindset and how that can change your life. Super inspiring!",
    "Coffee is life for me! I can’t start my day without it. Tea’s nice and all, but nothing beats that first cup of coffee in the morning.",
    "I can’t resist pizza and ice cream. They’re like my ultimate comfort food combo! Just thinking about it makes me happy.",
    "I’d love to have dinner with Cleopatra! Just imagine the stories she’d tell about her life. It would be wild to hear about ancient Egypt firsthand.",
    "I’ve always wanted to try painting. It looks so relaxing, and I feel like it’d be a great way to express myself creatively.",
    "After a long day, I usually just kick back with some good music or a movie. It helps me unwind and forget about all the stress.",
    "The best advice I ever got was to just be myself and not worry about what others think. It’s super freeing to just live life on my own terms.",
    "If I could relive any moment, it’d definitely be my last birthday. We had a huge party with all my friends, and the memories still make me smile.",
    "I literally can’t live without my phone! It’s my lifeline for staying connected with everyone and finding new stuff to do.",
    "I believe in free will. I think we all have the power to shape our own destinies, even if it doesn’t always feel that way.",
    "I’m all about action flicks! There’s just something so thrilling about the fast pace and intense scenes. They keep me on the edge of my seat!",
    "If I could master any skill, it’d definitely be playing the guitar. It seems like such a cool way to express myself and have fun with music.",
    "When I’m feeling down, I try to keep myself motivated by focusing on my goals. Setting small tasks really helps me push through tough times.",
    "The last song I had on repeat was probably something by Olivia Rodrigo. Her lyrics really resonate with me, especially the ones about growing up.",
    "If I had to describe myself in three words, I’d say I’m creative, chill, and loyal. Those qualities mean a lot to me.",
    "My favorite childhood memory has to be playing outside with my friends during summer break. We’d have the best adventures, just being kids.",
    "For my birthday, I like to keep it low-key with close friends and family. A good dinner and some laughs are all I need to feel celebrated.",
    "Traditions are huge for me, especially family dinners during holidays. It’s always nice to catch up and enjoy good food together.",
    "If I could only eat one type of cuisine forever, it would definitely be Italian. Pasta, pizza, and gelato? Yes, please!",
    "My biggest fear has to be heights. I can’t even think about looking down from a high place without feeling super anxious!",
    "I’d switch lives with Elon Musk for a day, just to see what it’s like to be in his shoes and maybe learn a thing or two about innovation.",
    "Right now, I’m working towards finishing my degree. It’s been a long journey, but I’m determined to cross that finish line!",
    "To me, success is being happy with what you have and finding joy in the little things. It’s not just about money or fame.",
    "I love staying active by hiking. Being out in nature and exploring new trails always gives me a sense of peace.",
    "I like to plan things out, but I also enjoy being spontaneous sometimes. A mix of both keeps life exciting!",
    "My dream job would be something in the creative field, like graphic design or writing. I’d love to make a living doing what I love.",
    "When I’m stressed, I usually turn to music or go for a walk. It helps clear my mind and puts me in a better headspace.",
    "The last thing that made me laugh was a funny meme I saw online. It was one of those relatable ones that hit way too close to home!",
    "I’m super passionate about environmental issues. I think it’s so important to take care of our planet for future generations.",
    "If I could have any superpower, I’d choose teleportation. Imagine being able to visit any place in the blink of an eye!",
    "Fall is my favorite season. The cool weather, cozy sweaters, and pumpkin spice everything make me so happy!",
    "My biggest pet peeve is when people chew with their mouths open. It’s just so annoying and rude!",
    "If I could learn any language, I’d love to learn Spanish. It sounds beautiful and would be so useful for traveling.",
    "The movie that made me cry was ‘A Walk to Remember.’ The story is so touching, and it really hits hard.",
    "I’ve always felt a connection to the number 7. It just feels lucky to me, and I always seem to gravitate toward it.",
    "Greece is a place I’ve always wanted to visit. The history, architecture, and beaches all look incredible!",
    "My favorite way to relax is by curling up with a good book and a cup of tea. It’s the perfect escape from reality.",
    "If I could change one thing about the world, it would be to promote kindness and understanding among people. We need more of that!",
    "My favorite ice cream flavor is cookie dough. It’s the best mix of creamy and chewy, and I can’t resist it!",
    "I definitely believe there’s life out there. The universe is so vast; it just makes sense that we’re not alone.",
    "The most adventurous thing I’ve ever done is going skydiving. The adrenaline rush was insane, and I’d do it again in a heartbeat!",
    "I love expressing my creativity through writing. It’s a great outlet for my thoughts and feelings.",
    "If I could time travel, I’d definitely go to the future. I’m super curious about what’s to come!",
    "A quote that inspires me is, ‘The only limit is your mind.’ It reminds me to push past my own barriers.",
    "The best concert I’ve been to was when I saw Billie Eilish live. Her energy was incredible, and I’ll never forget it!",
    "If I could have any animal as a pet, I’d pick a dragon. It’d be so cool to have a mythical creature as a companion!",
    "My favorite holiday is Christmas. I love the decorations, the spirit of giving, and spending time with family.",
    "I can juggle a bit! It’s a fun party trick, and I love showing it off when I can.",
    "Seeing my dog wag his tail always makes me smile. It’s the little things that bring the most joy!",
    "If I could meet any celebrity, it’d be Harry Styles. He seems so down-to-earth and talented!",
    "I love spending time outdoors, whether it’s hiking, biking, or just relaxing at the park. Nature is my happy place.",
    "One challenge I’ve overcome was my fear of public speaking. I took a class and now I feel much more confident!",
    "To stay organized, I use a planner and make lists. It helps me keep track of everything I need to do.",
    "The best gift I ever received was a handmade scrapbook from my best friend. It was so thoughtful and really touched my heart.",
    "I love my sense of humor; it helps me get through tough times and makes life more enjoyable.",
    "If I could only watch one TV show for the rest of my life, it’d probably be ‘Friends.’ It never gets old!",
    "A song that always lifts my mood is ‘Happy’ by Pharrell. I can’t help but dance whenever it comes on!",
    "I like to start my day with some meditation and a healthy breakfast. It sets a positive tone for the rest of the day.",
    "One fear I’ve conquered is my fear of heights. I went zip-lining and it was such a thrill!",
    "My favorite thing to do with friends is just hanging out and having deep conversations. Those moments mean a lot.",
    "If I had to live in a different country, I’d pick Japan. The culture and food are just so fascinating to me!",
    "My go-to karaoke song is ‘Livin’ on a Prayer.’ Everyone loves to sing along, and it’s such a classic!",
    "A dream I hope to achieve is to travel the world and experience different cultures. There’s so much out there to explore!",
    "If I could have dinner with any fictional character, it’d be Samwise Gamgee from ‘Lord of the Rings.’ He’s so loyal and brave!",
    "My favorite type of weather is when it’s sunny but with a cool breeze. Perfect for being outside!",
    "A habit I’d like to break is procrastinating. I always put things off until the last minute, and I want to change that.",
    "When I have disagreements with friends, I try to communicate openly and find common ground. It’s all about understanding each other.",
    "The best piece of advice I’d give is to always follow your heart."
  ];
  String newText = "";
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool canBeExited = true;
  @override
  void initState() {
    super.initState();

    if (mounted) {
      if (MyMails.names.isNotEmpty) {
        randomName = MyMails.names[rnd.nextInt(MyMails.names.length - 1)];
      }
      convo.add([questions[rnd.nextInt(questions.length - 2)], false, false]);
      setState(() {});
    }
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    for (int i = 0; i < convo.length; i++) {
      if (convo[i][2] == true) {
        convo[i][0].dispose();
      }
    }
    Timer.periodic(const Duration(seconds: 1), (timer) {});
    super.dispose();
  }

  void scrollToBottom(bool userInteraction) {
    if (userInteraction == false) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 174, 88, 175), // Email Top Bar
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          randomName,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 210, 176, 208),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTapDown: (_) => setState(() => userInteraction = true),
                onTapUp: (_) => setState(() => userInteraction = false),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: convo.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final isUserMessage = convo[index][1];
                    bool isAd = convo[index][2];
                    if (isAd == false) {
                      if (convo[index][0].runtimeType == String) {
                        return Align(
                          alignment: isUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isUserMessage
                                  ? const Color.fromARGB(
                                      255, 191, 148, 188) // Sent background
                                  : const Color.fromARGB(
                                      255, 96, 59, 97), // Received background
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              convo[index][0],
                              style: TextStyle(
                                color: isUserMessage
                                    ? const Color.fromARGB(
                                        255, 43, 30, 37) // Sent text color
                                    : const Color.fromARGB(255, 210, 176,
                                        208), // Received text color
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Align(
                          alignment: isUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isUserMessage
                                  ? const Color.fromARGB(
                                      255, 191, 148, 188) // Sent background
                                  : const Color.fromARGB(
                                      255, 96, 59, 97), // Received background
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: convo[index][0],
                          ),
                        );
                      }
                    } else {
                      return Container(
                          height: 200, child: AdWidget(ad: convo[index][0]));
                    }
                  },
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textController,
                      style: const TextStyle(color: Color(0xFF2B1E25)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFAE58AF), // Proper background color
                        hintText: "Type a message",
                        hintStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (String val) {
                        newText = val;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  decoration: const BoxDecoration(
                    color: Color(0xFFAE58AF), // Top bar and icon color
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      canBeExited = false;
                      int x = rnd.nextInt(4);
                      convo.add([newText, true, false]);
                      textController.clear();
                      scrollToBottom(userInteraction);
                      setState(() {});

                      if (x == 0) {
                        convo.add([
                          TypingIndicator(
                              backgroundColor: Color.fromARGB(255, 96, 59, 97),
                              dotColor: Color.fromARGB(255, 210, 176, 208)),
                          false,
                          false
                        ]);
                        Timer(const Duration(seconds: 3), () {
                          convo.removeLast();
                          convo.add([
                            response[rnd.nextInt(response.length - 2)],
                            false,
                            false
                          ]);
                          scrollToBottom(userInteraction);
                          convo.add([
                            TypingIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 96, 59, 97),
                                dotColor: Color.fromARGB(255, 210, 176, 208)),
                            false,
                            false
                          ]);
                          setState(() {});
                          Timer(const Duration(seconds: 6), () {
                            convo.removeLast();
                            convo.add([
                              longerTexts[rnd.nextInt(longerTexts.length - 2)],
                              false,
                              false
                            ]);
                            scrollToBottom(userInteraction);
                            setState(() {});
                            canBeExited = true;
                          });
                        });
                      } else if (x == 1) {
                        convo.add([
                          TypingIndicator(
                              backgroundColor: Color.fromARGB(255, 96, 59, 97),
                              dotColor: Color.fromARGB(255, 210, 176, 208)),
                          false,
                          false
                        ]);
                        Timer(const Duration(seconds: 3), () {
                          convo.removeLast();
                          convo.add([
                            response[rnd.nextInt(response.length - 2)],
                            false,
                            false
                          ]);
                          scrollToBottom(userInteraction);
                          convo.add([
                            TypingIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 96, 59, 97),
                                dotColor: Color.fromARGB(255, 210, 176, 208)),
                            false,
                            false
                          ]);
                          setState(() {});
                          Timer(const Duration(seconds: 3), () {
                            convo.removeLast();
                            convo.add([
                              questions[rnd.nextInt(questions.length - 2)],
                              false,
                              false
                            ]);
                            scrollToBottom(userInteraction);
                            setState(() {});
                            canBeExited = true;
                          });
                        });
                      } else if (x == 2) {
                        convo.add([
                          TypingIndicator(
                              backgroundColor: Color.fromARGB(255, 96, 59, 97),
                              dotColor: Color.fromARGB(255, 210, 176, 208)),
                          false,
                          false
                        ]);
                        Timer(const Duration(seconds: 3), () {
                          convo.removeLast();
                          convo.add([
                            response[rnd.nextInt(response.length - 2)],
                            false,
                            false
                          ]);
                          scrollToBottom(userInteraction);
                          convo.add([
                            TypingIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 96, 59, 97),
                                dotColor: Color.fromARGB(255, 210, 176, 208)),
                            false,
                            false
                          ]);
                          setState(() {});
                          Timer(const Duration(seconds: 6), () {
                            convo.removeLast();
                            convo.add([
                              longerTexts[rnd.nextInt(longerTexts.length - 2)],
                              false,
                              false
                            ]);
                            scrollToBottom(userInteraction);
                            convo.add([
                              TypingIndicator(
                                  backgroundColor:
                                      Color.fromARGB(255, 96, 59, 97),
                                  dotColor: Color.fromARGB(255, 210, 176, 208)),
                              false,
                              false
                            ]);
                            setState(() {});
                            Timer(const Duration(seconds: 3), () {
                              convo.removeLast();
                              convo.add([
                                questions[rnd.nextInt(questions.length - 2)],
                                false,
                                false
                              ]);
                              scrollToBottom(userInteraction);
                              setState(() {});
                              canBeExited = true;
                            });
                          });
                        });
                      } else {
                        convo.add([
                          TypingIndicator(
                              backgroundColor: Color.fromARGB(255, 96, 59, 97),
                              dotColor: Color.fromARGB(255, 210, 176, 208)),
                          false,
                          false
                        ]);
                        Timer(const Duration(seconds: 3), () async {
                          convo.removeLast();
                          convo.add([
                            videoPrompt[rnd.nextInt(videoPrompt.length - 2)],
                            false,
                            false
                          ]);
                          scrollToBottom(userInteraction);
                          newAd();
                          Timer(const Duration(seconds: 3), () {
                            convo.add([
                              questions[rnd.nextInt(questions.length - 2)],
                              false,
                              false
                            ]);
                            scrollToBottom(userInteraction);
                            setState(() {});
                            canBeExited = true;
                          });
                        });
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
