---
layout: post
title:  "Crazy And Not So Crazy Startup Ideas (2015 edition)"
date:   2015-01-15 17:00:00
categories: startup ideas
---

- [1. Bitcoin (Read-Only) Wallet as a Service](#1.-bitcoin-(read-only)-wallet-as-a-service)
- [2. Turnkey website for factories on Alibaba.com](#2.-turnkey-website-for-factories-on-alibaba.com)
- [3. Startup as a Service](#3.-startup-as-a-service)
- [4. Cold Calling as a Service](#4.-cold-calling-as-a-service)
- [5. Door to Door Marketing as a Service](#5.-door-to-door-marketing-as-a-service)
- [6. Proxy as a Service or Distributed Javascript as a Service](#6.-proxy-as-a-service-or-distributed-javascript-as-a-service)
- [7. Advice/Consulting as a Service](#7.-advice/consulting-as-a-service)
- [8. Algorithmic website theme generation](#8.-algorithmic-website-theme-generation)
- [9. Microservices Marketplace (aka the NPM/GEM of Microservices)](#9.-microservices-marketplace-(aka-the-npm/gem-of-microservices))
- [10. Module/Package/Library Search Engine](#10.-module/package/library-search-engine)
- [11. (Professional) Hackaton League](#11.-(professional)-hackaton-league)
- [12. Code as a Service](#12.-code-as-a-service)
- [13. A GUI interface for fig.sh and other similar tools](#13.-a-gui-interface-for-fig.sh-and-other-similar-tools)
- [14. Hosted Open Source Software as a Service](#14.-hosted-open-source-software-as-a-service)
- [Conclusion](#conclusion)

# 1. Bitcoin (Read-Only) Wallet as a Service

### Problem

<img src="/images/btc_logo.png" align="right">

A lot of people use desktop Bitcoin wallets because they don't require
trust in a third party. The problem with those wallets is that they are
hard to extend and build upon.

### Solution

An read only web wallet would enable third party developers to offer
services that require access to someone's wallet data. For example:

- A tax calculation service
- A money management service like [Mint](http://www.mint.com)
- Sales reports service for business wallets
- Receiving Bitcoin safely without having to run a Bitcoin node or a
    custom code.
- Triggering actions when Bitcoin is received or spent from the wallet.
    For example: Send an SMS when X BTC was spent from the
    wallet. Update a user's balance when BTCs are received to a specific
    address. Send me a warning when my balance goes below X BTC.
- Monitoring a cold wallet
- Embeded the wallet on any web page. This could be used by charities
    who want to be transparent about their finances.

If this read-only wallet service offers an API, other developers could
build those services using OAuth to demand access to a user's wallet, in
the same standard way many developers build upon Facebook or Twitter.
This could enable the creation of an app eco-system for Bitcoin wallets.

Here's how a typical user would use the service:

1. Create account with email/password/2FA.
2. Enter Electrum "read seed" (aka public master key), BIP39 "read" seed
   or add addresses manually. There could also be a "Connect with
   Coinbase" to access Coinbase's API or other exchange/web wallet
   services.
3. The wallet would then display the history of transactions (in real
   time).

There could also be an option for users to enter some private key in
order to be able to spend from the wallet although the wallet should
probably limit the amount of spendable BTCs to a fixed amount.

Some inspiration:

- Paypal's Instant Payment Notification API (something similar could be
    implemented)

### Why it might work

There's a lot of Bitcoin apps waiting to be written but not many people
who understand Bitcoin well enough to write all the code from scratch.
Having a simple API to interact with wallets would enable more
developers to build on top of Bitcoin.

### Why it might not work

A lot of people do not want to share their financial information with a
third party. There is a lot of competition in the space. It's not clear
how to monetize the service.

# 2. Turnkey website for factories on Alibaba.com

### Problem

<img src="/images/alibaba_logo.png" align="right">

A lot of the factories on Alibaba pour in millions in revenues but yet
they have dated or no website at all.

### Solution

Provide pre-built websites tailored for those factories.

This could be done by scraping data from Alibaba.com and populating the
and open source platform such as Magento (e-commerce) or Wordpress with
the company's information and catalog.

The process can be completely automated:

- Crawl Alibaba for companies.
- Pick a theme randomly or heuristically depending on the
    companie's industry for example. Themes could also be generated on
    the fly (using a selection of fonts, colors, layouts) so that every
    company gets a unique theme.
- Scrape data such as company name, logo, location, industry, product catalog
   and populate the database of a simple CMS or e-commerce system.
- Put the website online at http://**companyname**.turnkeywebsite.com
- Put a small banner on top of the website with a call to action to buy
    the website for X$/month.
- Email or message the company with the website's URL and an
    introduction text.

The same idea and process could be applied to Ebay, Amazon, Yelp,
Elance.com (for freelancers instead of businesses), etc.

### Why it might work

Even if 1% of your generated websites generate sales at 10$ month, that
could add up quickly if you are able to reach hundred thousands or
millions of users. Remember, the process can be entirely automated.

### Why it might not work

You might be violating Alibaba's ToS and get blocked from crawling. You
might not get on spam lists. You might end up doing more support then
expected.

Possible (unethical) fix: use a bunch of proxies.

# 3. Startup as a Service

<img class="img-rounded" src="/images/startuplogos.jpg" align="right">

### Problem

When you create a new project or startup, you have to sign up for a
bunch of different services, grab a domain name, setup hosting, setup
email, etc.  Maybe get a 1-800 number?  Sometimes, you don't even know
what services could help your business. Similarly, freelancers and web
development shops are often require to setup those things for their
clients although it is not their core expertise.

### Solution

Build a service where someone can pick a bunch of services (e.g. Google
Apps, Gmail, AWS, Reddit, AngelList, UserVoice, etc.) or a service
bundle (e.g.  SaaS bundle) to sign up for. The service would then
generate a form which will encompass the minimal information needed to sign
up for those services. The service would then send all the appropriate
POST requests and possibly outsource CAPTCHAs verification (e.g. to Amazon
Mechanical Turk).

### Why it might work

I personally would kill for such a service.

There are already similar services that are known as "cloud integration"
([SnapLogic](http://www.snaplogic.com/)). I am not sure however if they offer a
service comparable to the one I described.

### Why it might not work

This is probably against the ToS of all the servcies mentioned above.
Also, some of those services require CC information and I'm not sure
MasterCard/Visa would allow such a service to exist.

Possible (unethical) fix: use a bunch of proxies.

# 4. Cold Calling as a Service

<img class="img-rounded" src="/images/coldcall.jpg" align="right">

### Problem

If you are anything like me, you probably hate talking on the phone,
especially to strangers. Plus, you might have a weird accent or not all
that fluent in spoken English. Or maybe talking on the phone makes you
nervous? Or maybe you are scared you might burn a bridge if the phone
call goes badly. Or maybe you just don't have enough time to call all
those people you want to call? Or maybe you are living abroad and your
phone line sucks? Wouldn't it be nice if you could
outsource those painful phone calls to someone else?

### Solution

Build a platform where people can submit phone call requests. Those
requests should contain:

- A list of phone numbers and possibly information about the recipient
    of the call.
- The purpose of the call.
- How the caller should present him(her)self.
- What information / actions the call should produce.

There's a few way to execute that idea. There could be a way for people
to sign up as "callers" and bid on requests and be rated/reviewed by
requesters. The callers could also be only "in-house" and pre-selected.

The pricing could be "per minute" and the calls could be automatically
recorded.

Another possible twist: it could be possible for the requesters to
listen in on live calls and provide instant feedback to the callers
through a chatroom or another audio channel which only the caller can
hear.

Another possible twist: if the service has an API, third party
developers could build apps which require a human talking on the phone.
One idea that comes to mind would be a non-robotic appointment reminder
service.

### Why it might work

I think a lot of startup founders are introverts and would be ready to
pay to outsource phone calls.

### Why it might not work

I'm sure there's a ton of competition in that space already (e.g.
[ElasticSales](https://elasticsales.com://elasticsales.com/) but it
closed recently). There's also the problem of how the callers should
introduce themselves.  Obviously, they can't introduce themselves as a
company employee but at the same time, it would be better if they didn't
say straight away that they are a professinal "caller". There is
obviously some ways to get around that problem some of which could be
considered unethical.

# 5. Door to Door Marketing as a Service

<img class="img-rounded" src="/images/door2door.jpg" align="right">

### Problem

For some businesses (e.g. restaurants, lawn mowing, cleaning service,
laundry service, hairdressers, painting, etc.) the best way to advertise
is locally. One way to do that is to go door to door in the
neighboorhood and offer your services or slip a small flyer in the
mailbox or under the door.

This doesn't scale well and it's not always easy to find people who will
do it for you.

### Solution

Offer a service where localized business can specify an area to cover
and a description of what has to be done at every door.

The most obvious pricing model would X$ per door or through a bidding
process.

### Why it might work

There's a lot of small businesses out there who need more customers.

### Why it might not work

It's difficult to market that service. The best way would be to start
with a specific area and expand from there.

It's not clear that in the Internet age, door to door marketing is still
an efficient way to market services.

Most small business don't necessarily have a budget for that.

# 6. Proxy as a Service or Distributed Javascript as a Service

<img class="img-rounded" src="/images/malware.jpg" align="right">

**Warning: I'd say this idea is pretty unethical and I'd suggest
you don't implement it.**

### Problem

Sometimes you just want to abuse a website but run out of IPs. Or maybe
you want to do a distributed computation for cheap?

### Solution

A lot of websites have difficult to monetize traffic (porn websites,
content farms, etc.). What if they could embed a small Javascript script and
earn money on every visit?

The idea here would be to build a marketplace where people could
submit Javascript programs and have the code run on thousands of machines
with different IPs.

Webmasters could signup for the service by adding a small embed
Javascript in their pages.

The system would automatically dispatch the submitted Javascript
programs on all the participating webmasters websites, similarly to how
ad networks do.

This service could be used to run distributed computations or perform
HTTP requests using thousands of IPs.

### Why it might work

There's a lot of hard to monetize traffic out there and lots of people
who want to perform computations cheaply or cover their origin using
multiple IPs.

### Why it might not work

This idea is unethical and possibly illegal. Also, cross origin policy
and CSRF tokens could make this unusable as a distributed proxy service.
Also, IPv6 makes it a lot easier to evade IP level ban. This service
could be gamed as ad networks frequently are. There is also the
chicken/egg proglem: how to get webmasters if there are no one to submit
requests and vice versa.

# 7. Advice/Consulting as a Service

<img class="img-rounded" src="/images/question.jpg" align="right">

### Problem

Sometimes you know someone who has expertise in a domain and could
help you out but you don't exactly know how to reach them or make it
worthwhile for them. Or maybe you'd like a code review from an expert?

### Solution

Buil a service where people can enter the email and name of the person
they wan advice from. Pick a hourly rate you are willing to pay or let
the recipient pick one. The service would then send out a customized
email to the recipient which would describe the request and let him
agree/deny it. If the recipient agrees, the two participants are
scheduled for a call. The call should be proxied through the service so
that calling time can be monitored and the correct amount can be
transfered to the callee's balance.

Possible use case: "I want to develop software for hairdressing
businesses but I don't know anyone in that business so I'd like a
hairdresser business owner to answer some of my questions."

### Why it might work

It's more efficient and possibly cheaper than inviting someone for a
coffee which is the typical way to solve the problem right now.

### Why it might not work

There's already similar services on the market although I believe most
of them require the call recipient to be already signed up with the
service. It's also not clear how to market the service.

# 8. Algorithmic website theme generation

<img src="/images/themeforest_logo.png" align="right">

Devise an algorithm that can generate website theme. The algorithm could
work as following:

- Pick a color theme from a predefined collection of color themes
- Pick a layout from a predefined collection of layouts. The algorithm
    could be recursive: each layout element (e.g. header) could have a
    collection of sub-layouts to pick from.
- Pick a font theme from a predefined collection of fonta
- Generate a logo
- Randomly pick pictures and backgrounds images if the layouts requires
    some.

The generated themes could be automatically submitted to theme marketplaces
such as [ThemeForrest](themeforest.net). This idea was inspired by the
automatically generated books that are sold on Amazon. This might be
against the ToS of some theme marketplaces.

# 9. Microservices Marketplace (aka the NPM/GEM of Microservices)

<img class="img-rounded" src="/images/microservices.jpg" align="right">

Microservices architecture is rapidly gaining popularity. The idea is to
build larger systems composed of smaller self contained services who own
their data. The services typically communicate with each others through
REST APIs or a messge queue.

It would be nice if web applications could be built more rapidly by re-using
common services: a user/authentication service, a mailing service, a CMS
service, etc.

This is already commonly done at the library or framework level. For
example, Rails and Django have a large selection of third-party
components that handle common stuff.

However, those are built with the monolithic architecture in mind. It
would be nice if it was as easy to import those modules as self
contained microservices and hopefuly reduce coupling.

This is not a new idea (see
[SOA](http://en.wikipedia.org/wiki/Service-oriented_architecture) and
[Enterprise
Integration](http://en.wikipedia.org/wiki/Enterprise_integration))
but the things that hindered the adoption of SOA might not be
problematic today.

The marketplace could be open source or paid. Docker containers +
fig.yml could be used as a package format for example.

Many apps already are composed of a bunch of third party services (e.g.
MailChimp, Mashape, UserVoice, etc.) and I could see those services
being displaced by a marketplace that lets developers run the services
by themselves. This was problematic in the past but the rapidly evolving
devops movement brought many open source tools that make self-hosting
much easier.

# 10. Module/Package/Library Search Engine

<img class="img-rounded" src="/images/npm.png" align="right">

Most package repositories ([npm](https://www.npmjs.com/),
[gems](https://rubygems.org/search), [PyPi[(https://pypi.python.org))
don't get search quite right. Most developers prefer to head directly to
Github and pick libraries according to their starts count.

I'm sure we can do better than that. What if there was a library search
engine that could find the best possible library given a language and a
few key words?

Some signals that could be used to rank libraries:

- Code quality metrics
- Github stars count
- Creation data, recent commits
- Author
- Number of libraries that depend on the library
    ([PageRank](http://en.wikipedia.org/wiki/PageRank) like algorithm?)
- Number of downloads
- Number of closed and opened issues
- Number of tests (do they pass?)
- Documentation?

# 11. (Professional) Hackaton League

<img src="/images/hackaton.jpg" class="img-rounded" align="right">

There are lots of [eSports gaming
leagues](http://en.wikipedia.org/wiki/Electronic_sports) but the closest
we have in the hacker/startup world are one off or "once a year"
hackatons. What if there was a league for hackatons that would operate
similarly to how gaming leagues operate?

The idea would be to build a "MVP league" that would combine aspects
of eSports leagues and online hackatons (e.g. [Node Knockout](nodeknockout.com)).

Participants could form teams and submit a new MVP every X weeks.
Another option would be to have theme/technology based tournaments (e.g.
"open source", "Node.js", "education").

Winners could be selected after each cycle, new teams could be formed,
there could be a leaderboard of teams/participants, etc. Sponsors could
offer prizes to winners or investors could offer funding.

Additionally, this would be a great way to meet potential co-founders
and socialize with like minded peers.

There are already a couple of websites that aggregate online hackatons
([ChallengePost](http://challengepost.com),
[WeHack.it](http://www.wehack.it/)) but I haven't seen one
that operates as a league and most online hackatons are one off things
or once a year things.

# 12. Code as a Service

<img src="/images/tdd.png" class="img-rounded" align="right">

The idea is about taking Test Driven Development to its limit.

The service would allow developers to write a series of test that must
pass and wait for someone to write the code that passes the tests.
Money/karma would be automatically awarded to the first person who
successfuly submits code that passes the tests.

The biggest problem with this idea are:

- In many cases, it's easy to game the tests
- Most developers don't have a budget for this or don't know how to
    price the code they need.
- Sometimes writing the tests is as difficult or time consuming as
    actually writing the code.

# 13. A GUI interface for fig.sh and other similar tools

<img src="https://juju.ubuntu.com/wp-content/uploads/2013/10/homepage-hero.png" class="img-rounded" align="right">

Allow devops and sysadmins to visualize and orchestrate their operatioins infrastructure
through a simple GUI. Logical services could be represented as squares
with the name of the service in it and services that depend on each
others (need to communicate) could be linked with lines.

The tool could support
[fig.yml](http://www.fig.sh), [TerraForm](https://www.terraform.io/),
[Kubernetes](http://kubernetes.io),
[BOSH](http://docs.cloudfoundry.org/bosh/) or
[Vagrant](http://www.vagrantup.com) for example.

[Ubuntu Juju](https://juju.ubuntu.com/) is a tool that does something
along those lines although I don't think it can read/write to a
configuration file such as `fig.yml` which is not ideal which is not
ideal if you want to keep your [infrastructure as code](http://devops.com/blogs/meet-infrastructure-code/) and keep it
versioned in a Git repository.

# 14. Hosted Open Source Software as a Service

<img src="/images/opensource.png" class="img-rounded" align="right">

This is not really a specific startup idea but a general business model
that is not especially novel.

There is a lot of open source software out there that can be hard to install
or operate for the average consumer or even developers. The idea is to pick an open
source software and completely automatize its deployment.

You can then put ut a simple website where people can sign up and pay a
monthly fee for you to run the software for them.

Obviously, most well known open source software (e.g. Wordpress) already
have tons of [companies](http://www.wordpress.com) doing this but some
more obscure software might not yet have such service available.

# Conclusion

Hope you liked my crazy shower ideas. Let me know if you plan to execute
on one or if you'd like to suggest your own ideas in the comments.

