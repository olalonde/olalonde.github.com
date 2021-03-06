---
permalink: /some-crazy-and-not-so-crazy-startup-and-proje
sharing_link: /some-crazy-and-not-so-crazy-startup-and-proje/
layout: post
title: 17 crazy and not so crazy startup and project ideas
published: true
comments: true
categories:
- hacker-news
- idea
---
<p class="alert"><strong>Update:</strong> I've written a <a
href="/crazy-and-not-so-crazy-startup-ideas-2015-edition/">2015 edition</a>.</p>

<p>So today I am cleaning up my phone&rsquo;s Memo app so this post will be
dedicated to dumping all those late night ideas I had when I was very
tired or had a few too many beers. Note that I had most of those ideas
independently but some of them were (partially) implemented later on
or I simply hadn&rsquo;t heard of them.</p>

<h2>1. Beetcoin</h2>

<p>Mobile app that acts as a nice UI on top of various Bitcoin exchanges.
It should be possible to view pending trades, get current bid/ask
prices and place new trades.</p>

<p><strong>The twist:</strong> Sell it as a paid app and give away &ldquo;free&rdquo; Bitcoins. The
app should be expensive enough that when you give away Bitcoins you
still make a profit.</p>

<p><strong>Why it will work:</strong> This would enable regular people to buy Bitcoins
with their credit card by buying the app on the Android market.</p>

<p><strong>Why it won&rsquo;t work:</strong> It is possibly against most markets / credit card
processors TOS.</p>

<h2>2. Code reading web app</h2>

<p>Reading other people&rsquo;s code is one of the surest way to improve your
programming skills. For each programming language, this app would list
open source projects by difficulty level (from beginner to expert) and
make it easy to browse and comment the code from within the website.
The MVP could simply list links to Github repos. Inspiration comes
from <a href="http://todomvc.com">http://todomvc.com</a>.</p>

<p>Use case: I just started to learn Javascript and I want to see some
real world Javascript code. I go to the site, select the Javascript
language and I can see a list of projects rated from Beginner level to
Expert level. Each projects that are at the same difficulty level are
grouped together. The beginner level should list simple &ldquo;Hello world&rdquo;
apps while the expert level should be reserved for complex projects.</p>

<h2>3. Prediction market, Hacker News style</h2>

<p>Not sure what I meant when writing this. I think the idea is that it
would be a news aggregator like Hacker News but when you vote up it
costs you real money (you are investing in a vote). If the vote count
goes up, you are rewarded for predicting correctly that the article
was interesting to the community. The reward should be proportional to
how many people up voted after you. I guess someone still needs to
work out the &ldquo;details&rdquo;. The whole idea is to mix karma with money to
self-moderate a community (most people care more about money than
karma).</p>

<h2>4. OAuth for payments</h2>

<p>I&rsquo;m not sure why I haven&rsquo;t seen this yet in the wild. Probably due to
legal compliance and security issues. But well, I think it would be
cool if I could just buy stuff by clicking &ldquo;Pay 10$&rdquo; and whenever I
click that button, I get the standard OAuth dialog asking me to
authorize the payment. There should be a maximum amount by transaction
which should be fairly low if security is an issue (50$?).</p>

<h2>5. URL#hash renderer API</h2>

<p>I first had this idea when developing a website with Backbone.js. All
my URLs looked like <a href="http://domain/#a/b/c">http://domain/#a/b/c</a> and I thought it would be
nice if my server could proxy all requests to <a href="http://domain/a/b/c">http://domain/a/b/c</a>
through an API that returns the rendered HTML of <a href="http://domain/#a/b/c">http://domain/#a/b/c</a>.</p>

<p>Some websites are not crawlable or unusable if users don&rsquo;t have
Javascript enabled. This service takes an url of the form
<a href="http://domain/#hash">http://domain/#hash</a> and returns the rendered HTML that a user would
see if they had Javascript enabled. Web developers could use this
service to easily offer a crawlable website that is friendly to
visitors that have Javascript disabled.</p>

<h2>6. Startups for front-end developers</h2>

<p><strong>Update:</strong> I think Hoodie is a solution. See <a href="http://hood.ie/">http://hood.ie</a></p>

<p>Build a service that makes it possible to develop a full website
completely on the client side (probably using Backbone.js or similar),
interfacing with a list of predefined APIs. This startups' job would
be to take care of providing a list of easily accessible APIs and make
it easy for designers to publish UIs that interact with the APIs. The
startup should also take care of common issues like cross-origin
request sharing, caching, etc. Eventually, there would be a market
where developers can publish APIs. This idea is rooted in the idea of
division of labor. Backend developers should focus on what they do
best and so should frontend developers. Wouldn&rsquo;t it be nice if all
startups out there were simply a REST API with dozens of UIs you can
chose from. What if Paypal was simply an API and anyone could build a
nice UI on top of that API.</p>

<h2>7. Hacker News directory</h2>

<p>List all Hacker News related services, websites, Chrome extensions,
publications, apps, etc. There is currently no such official website.</p>

<h2>8. &ldquo;Hello dear [social network] user. I would really appreciate if you [tweeted/liked/up voted] this.&rdquo;</h2>

<p>This idea was inspired by seeing a few &ldquo;I see you are coming from HN.
Please up vote and comment.&rdquo; when clicking submissions on HN.</p>

<p>This should be a small embeddable script or iframe which should
display a small message asking to share the current page on a given
social network. The social network is chosen using the visitor&rsquo;s HTTP
referer header or their browser&rsquo;s history. The script should first
check if their referrer matches a social network and if not, use the
browser history hack to see if the user has recently visited a known
social network. This would be a good alternative for people who want
to have multiple sharing buttons but don&rsquo;t want to clutter the screen
real estate with too many choices.</p>

<h2>9. Offline Hacker News mobile app</h2>

<p>Whenever I have to go on a long subway ride with no 3G or Wifi, I
really wish I could just click a button that would load all HN&rsquo;s front
page submissions + comments and load them in my browser&rsquo;s tab before I
leave. Hence, the offline HN app idea.</p>

<h2>10. Github orphan</h2>

<p><strong>Update:</strong> this appears to have been somewhat solved since I had this
idea. See <a href="http://stillmaintained.com">http://stillmaintained.com</a></p>

<p>There should be an easy way to orphan and adopt new projects in Github.</p>

<h3>Use case: You want to orphan a project</h3>

<p>Connect with Github. Select project to orphan.</p>

<p>This automatically writes this at the top of your README file:</p>

<div class="CodeRay">
  <div class="code"><pre># ADOPT ME! #
I am no longer able to maintain this project. Click here to adopt it!</pre></div>
</div>


<h3>Use case: You want to adopt a project</h3>

<ol>
<li>Visit a Github project. See that it is open for adoption.</li>
<li>Click the adopt link in the README file.</li>
<li>Authenticate with Github</li>
<li>Wait for adoption authorization by current maintainer</li>
</ol>


<h3>Use case: Approve adopter</h3>

<ol>
<li>You see that someone applied to become a new maintainer for your project.</li>
<li>Click Approve.</li>
<li><p>Erase everything in your repository except a single README file:</p>

<p>   # THIS PROJECT IS NOW MAITAINED BY &lsquo;new maintainer&rsquo; AT
   github.com/new-maintainer/blabla #</p></li>
</ol>


<h2>11. Public transportation visualization and simulation</h2>

<p>Update: There is something in that vein available for London:
<a href="http://busmapper.co.uk/">http://busmapper.co.uk/</a>. Hey guys, if you are reading this, I&rsquo;m
available for hire :)</p>

<p>Wouldn&rsquo;t it be cool if you could see buses and subways on a map
traveling &ldquo;real time&rdquo; and seeing where they are going at a glance.
Let&rsquo;s say your on some street and want to go in some direction (let&rsquo;s
say downtown), you could just open that mobile app, see which buses
are coming your way and where they are going to. The simulation could
be computed by using bus schedule and averaging the speed between two
stops. I prototyped this a few years ago at
<a href="http://dev.syskall.com/map">http://dev.syskall.com/map</a>.</p>

<h2>12. Quadcopter delivery</h2>

<p><strong>Update:</strong> <a href="http://tacocopter.com/">Taco Copter</a></p>

<p>In areas of high density and high rise buildings, wouldn&rsquo;t it be nice
if you could order something from 7/11 and have a quadcopter (semi-)
autonomously deliver your stuff through the window/balcony?</p>

<h2>13. Pixel copter advertising</h2>

<p><strong>Update:</strong> <a href="http://senseable.mit.edu/flyfire/">MIT flyfire</a></p>

<p>Wouldn&rsquo;t it be nice to have a fleet of programmable mini pixel copters
(small helicopters that carry a colored light) draw images / video in
the sky. This could be used for promotion and advertising.</p>

<h2>14. Online food delivery</h2>

<p>This problem has been tackled many times and there are a few companies
doing it right now but it still hasn&rsquo;t gain lots of momentum. Anyways,
the idea is that you could just open up a mobile app / web app and
through geolocation, get a list of restaurants that can deliver to
your location. You can filter out the restaurants by cost, food type,
etc. You can then navigate to the menu and place your order.</p>

<p><strong>The twist:</strong> There are a lot of &ldquo;Amazon&rdquo; and &ldquo;Ebays&rdquo; in that space but I
haven&rsquo;t seen any &ldquo;Shopifys&rdquo; so far. Meaning that most of the startups
in that space, have a central website where they list restaurants.
Probably some restaurants would be interested in a white label
solution where they could host on their own domain and customize
everything to their needs.</p>

<h2>15. Instant UML diagram for a given Github repository</h2>

<p>I&rsquo;ve always wanted something like this. Select a given Github
repository and instantly get an UML class diagram, whatever the
language is. UML is not really a good fit for more dynamical languages
but nowadays there are statical analysis tools even for Javascript and
company.</p>

<h2>16. Ad-hoc sport teams</h2>

<p>You want to play a game of soccer? Open up this web app, change you
status to &ldquo;I want to play soccer in the next X hours&rdquo;. When there is
enough people who want to play at the same time as you within a given
geographical zone, we all notify you, you chose a location/time and
the game begins!</p>

<h2>17. Hotel Wifi web app</h2>

<p>You connect to your hotel&rsquo;s wifi and on first browser request, you get
redirected to this web app. The web app, displays events in the area,
there is a chatroom for other lonely and bored travelers, you can
order stuff from the hotel directly from the web app, there hotel
guest specific promotions from local businesses, etc. Maybe you will
find someone with similar tastes in the chatroom and you can hang out
together in this unknown city?</p>

<h2>Conclusion</h2>

<p>I think that&rsquo;s about it for now. I will update the post if I bump into
more crazy ideas while cleaning up my phone. Let me know what you
think in the comments and I&rsquo;d love to know if you&rsquo;re solving one of
these problems or planning to!</p>
