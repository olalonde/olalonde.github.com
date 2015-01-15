---
layout: post
title:  "Crazy And Not So Crazy Startup Ideas (2015 edition)"
date:   2015-01-15 17:00:00
comments: true
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

- A tax calculator.
- A money management service like [Mint](http://www.mint.com).
- Sales reports service for business wallets.
- Receiving Bitcoin safely without having to run a Bitcoin node or a
    custom code.
- Triggering actions when Bitcoin is received or spent from the wallet.
    For example: Send an SMS when X BTC was spent from the
    wallet. Update a user's balance when BTCs are received to a specific
    address. Send me a warning when my balance goes below X BTC.
- Monitoring a cold wallet.
- Embedded the wallet on any web page. This could be useful for charities
    who want to be transparent about their finances.

If this read-only wallet service offers an API, other developers could
build those services. OAuth could be used to gain access to a user's wallet, in
the same standard way many developers ask users access for their
Facebook/Twitter accounts.

This would enable the creation of an app ecosystem built around Bitcoin wallets.

Here's how a typical user would use the service:

1. Create account (email/password/2FA).
2. Enter Electrum "read seed" (aka public master key), BIP39 "read" seed
   or add some Bitcoin addresses manually. There could also be a "Connect with
   Coinbase" to access Coinbase's API or to other exchange/web wallet
   services.
3. The wallet would then display the history of transactions like
   desktop wallets do.

There could also be an option for users to add some private key(s) to
the wallet in order to be able to spend from it. However, the amount of
spendable BTCs should be limited to a small (insurable) amount.

Some inspiration:

- Paypal's Instant Payment Notification API (something similar could be
    implemented)

### Why it might work

There's a lot of Bitcoin apps waiting to be written but not many
developes understand the Bitcoin protocol well enough to write
apps for it. Having a simple API to interact with wallets would
empower more people to safely build on top of Bitcoin.

### Why it might not work

A lot of people do not want to share their financial information with a
third party even if that information is "read only". There is a lot of
competition in the space. It's not clear how to monetize the service.

# 2. Turnkey website for factories on Alibaba.com

### Problem

<img src="/images/alibaba_logo.png" align="right">

A lot of factories which are listed on [Alibaba](http://www.alibaba.com)
pour in millions of revenues but yet they have [dated
websites](http://www.bodawutong.com/) or no website at all.

### Solution

Provide pre-built websites tailored to the needs of those factories.

This could be done by scraping data from Alibaba.com and using that data
to populate open source platforms such as
[Magento](http://magentocommerce.com) (e-commerce) or
[Wordpress](http://www.wordpress.org) with the company's information and
catalog of products.

The process can be *completely automated*:

- Crawl Alibaba for companies.
- Pick a theme randomly or heuristically (depending on the
    company's industry for example). Themes could possibly be
    [generated on the fly](#8.-algorithmic-website-theme-generation).
- Scrape data such as company name, logo, location, industry, product catalog
   and populate the database of a simple CMS or e-commerce system.
- Put the website online at http://**companyname**.turnkeywebsite.com
- Have a small banner on top of the website with a call to action to buy
    the website for X$/month.
- Email or message their company's website URL and an
    introduction text (e.g. "We build this website for you, check it
    out!").

The same idea and process could be applied to sellers on Ebay, Amazon,
Yelp or even freelancers on Elance.com.

### Why it might work

Even if 1% of your generated websites generate sales at 10$/month, this
could add up quickly if you are able to reach hundred thousands or
millions of users. Remember, the process can be entirely automated.

### Why it might not work

You might be violating Alibaba's ToS and get blocked from crawling. You
might not get on email spam lists. You might end up doing more support then
expected.

Possible (unethical) fix: use a bunch of proxies.

# 3. Startup as a Service

<img class="img-rounded" src="/images/startuplogos.jpg" align="right">

### Problem

When you create a new project or startup, you have to sign up for a
bunch of different services, grab a domain name, setup hosting, setup
email, etc.  Maybe get a 1-800 number?

Sometimes, you don't even know which services could help you be more
productive.

Similarly, freelancers and web development shops are often required to
setup all those things for their customers even when it is not spelled
out in their contract.

### Solution

Build a service where a user can pick a bunch of services to sign up for
(e.g. Google Apps, Gmail, AWS, Reddit, AngelList, UserVoice, etc.) or a
pre-defined service bundle (e.g.  SaaS bundle).

The service would then generate a form which would encompass the
*minimal information required* (without repetition) to successfuly sign
up for all the selected services. The service would then execute all the
appropriate POST requests and possibly outsource CAPTCHAs verification
(e.g. to Amazon Mechanical Turk).

### Why it might work

I personally would kill for such a service.

There are similar services on the market that are sometimes described as
"cloud integration" services ([SnapLogic](http://www.snaplogic.com/)). I
am not sure however if the idea I just described is comparable to the
service they offer.

### Why it might not work

This is probably against the ToS of many of the servcies mentioned above.
Also, some of those services require credit card information and I'm not sure
MasterCard/Visa would allow such a service to handle credit card data.

Possible (unethical) fix: use a bunch of proxies.

# 4. Cold Calling as a Service

<img class="img-rounded" src="/images/coldcall.jpg" align="right">

### Problem

If you are anything like me, you probably hate talking on the phone,
especially to strangers. Plus, you might have a weird accent or you
might not be that fluent in spoken English. Or maybe talking on the
phone makes you nervous? Or maybe you are scared you might burn a bridge
if a phone call goes badly. Or maybe you just don't have enough time
to call all those people you want to call? Or maybe you are living
abroad and your phone line sucks?

Wouldn't it be nice if you could outsource those painful phone calls to someone else?

### Solution

Build a platform where people can submit phone call requests. Those
requests should contain:

- A list of phone numbers and information about the recipient
    of the call if available.
- The purpose of the call.
- How the caller should present him(her)self.
- What information / actions the call should produce.

There are a few way to execute this idea.

There could be a way for people to sign up as "callers" so you don't
have to hire and manage a bunch of people to do the calls.

Pricing of phone calls could be done by bidding similar to how
freelancing sites work.

Pricing could be "per minute" and the calls could be automatically
recorded and archived.

Another possible twist: make it possible for the call requesters to
listen in on live phone calls and have the ability provide instant
feedback to the callers through a private chatroom or through an audio
channel which only the caller can hear.

Another possible twist: if the service has an API, third party
developers could build apps which somehow require a human talking on the
phone.  One idea that comes to mind would be a non-robotic appointment
reminder service.

### Why it might work

This service would be immensely useful to people who need to
(temporarily) scale their cold calling infrastructure or for startup
founders who are scared of the phone!

### Why it might not work

I'm sure there's a ton of competition in that space already (e.g.
[ElasticSales](https://elasticsales.com://elasticsales.com/) - it
pivoted recently).

There's also the problem of how callers should
introduce themselves without sounding like "professional callers".

# 5. Door to Door Marketing as a Service

<img class="img-rounded" src="/images/door2door.jpg" align="right">

### Problem

For some businesses (e.g. restaurants, lawn mowing service, cleaning
service, laundry service, hairdressers, painting, etc.) the best way to
advertise is through local advertising.

One way to do that is to go from door to door in the neighborhood and to
either offer your services or slip a small promotional flyer in the
mailbox or under the door.

This doesn't scale well and it's not always easy to hire people who will
do the job for you.

### Solution

Offer a service where localized business can specify an area to cover
and a description of what has to be done at every door.

One obvious pricing model would be to charge per door.

### Why it might work

There's a lot of small businesses out there who need more customers!

### Why it might not work

It's difficult to market that service. The best way would be to start
small with a small area and expand from there.

It's not clear that in the Internet age, door to door marketing is still
an efficient way to market services.

Some small business don't necessarily have a budget for that.

# 6. Proxy as a Service or Distributed Javascript as a Service

<img class="img-rounded" src="/images/malware.jpg" align="right">

**Warning: I'd say this idea is pretty unethical but I still put it here
 in case it might inspire a better idea.**

### Problem

Sometimes you just want to abuse a website but your run out of non-banned IPs. Or maybe
you want to do a distributed computation for cheap?

### Solution

A lot of websites have "difficult to monetize" traffic (porn websites,
content farms, etc.). What if they could embed a small Javascript script and
earn money on every visit?

The idea here would be to build a marketplace where people could
submit Javascript programs and have the code run on thousands of machines
with different IPs.

Webmasters could sign up for the service by adding a small embed
Javascript in their pages.

The system would then automatically dispatch user submitted Javascript
programs on all the participating websites, similarly to how
ad networks work.

This service could be used to run distributed computations or perform
HTTP requests using thousands of IPs.

### Why it might work

There's a lot of hard to monetize traffic out there and lots of people
who want to perform computations cheaply or cover their origin using
tons of IPs.

### Why it might not work

This idea is unethical and possibly illegal. Also, cross origin policy
and CSRF tokens could make this unusable as a proxy service.  Plus, IPv6
makes it a lot easier to evade IP level ban.

This service could be gamed in the same way ad networks frequently are.

There is also the chicken/egg problem: how to get webmasters if there
are no one to submit requests and vice versa.

# 7. Advice/Consulting as a Service

<img class="img-rounded" src="/images/question.jpg" align="right">

### Problem

Sometimes you know about someone who has expertise in a domain and you
know this person could help you out but you don't know exactly how to
reach them or make their time worthwhile.

### Solution

Build a service where people can enter the email and name of the person
they need advice from (the mentor). They should also be able to specify
an hourly rate they are willing to pay or decide to let the mentor
pick one.

The service would then send out a customized email to the mentor asking
them if they want to accept the request.

If the recipient agrees, the system would match both recipients for a
time to do the call.

The call could be proxied through the service so that calling time is
monitored. At the end of the call, the correct amount would be deducted
from the requesters balance and awarded to the "mentor".

Possible use case: "I want to develop software for hairdressing
businesses but I don't know anyone in that business so I'd like a
hairdresser to answer some of my questions."

Twist: the general concept could also be applied to request code reviews
from experts.

### Why it might work

Using this platform would probably be more efficient and cheaper than
having to invite someone for coffee which is the typical way of doing
this today.

### Why it might not work

There are already similar services on the market although I believe most
of them require the "mentors" to already be signed up with the
service. It's also not clear how to market the service efficiently.

# 8. Algorithmic website theme generation

<img src="/images/themeforest_logo.png" align="right">

Devise an algorithm that can automatically generate website themes and
submit them on theme marketplaces. The algorithm could work as
following:

- Pick a color theme from a predefined selection of color themes
- Pick a layout from a predefined selection of layouts. The algorithm
    could be recursive: each layout element (e.g. header) could have
    selections of sub-layouts. [Natural language generation](http://en.wikipedia.org/wiki/Natural_language_generation)
    techniques could be useful here.
- Pick a font theme from a predefined selection of fonts. Selections
    could consist of "header" font, "main text" font, "monospace" font,
    etc.
- Generate a logo
- Randomly chose pictures and backgrounds images if the layouts needs
    some of them.

The generated themes could be automatically submitted to theme marketplaces
such as [ThemeForrest](themeforest.net). This idea is conceptually
similar to those people who generate books and put them for sale on
Amazon.

Be careful, doing this might be against the ToS of some marketplaces.

# 9. Microservices Marketplace (aka the NPM/GEM of Microservices)

<img class="img-rounded" src="/images/microservices.jpg" align="right">

Microservices architecture is rapidly gaining popularity. The idea is to
build larger systems composed of smaller self contained services who own
their data. Those services typically communicate with each others through
a REST API or a messge queue.

It would be nice if web applications could be built more rapidly by
being able to re-use common services: a user/authentication service, a
mailing service, a CMS service, an activity stream services, etc.

This is already possible at the library and framework levels. For
example, Rails and Django both have a large selection of third-party
components that can handle common use cases.

However, those components are built with the monolithic architecture in
mind. They are often built for a specific framework or language and they
often do not own their data.

It would be nice if instead of framework specific library/packages,
there was an easy way to import self contained, language agnostic,
microservices.

Those microservice packages could take the form of ([collections
of](http://www.fig.sh)) configurable Docker images for example.

This is not a new idea (see
[SOA](http://en.wikipedia.org/wiki/Service-oriented_architecture) and
[Enterprise
Integration](http://en.wikipedia.org/wiki/Enterprise_integration)) but
the things that hindered the adoption of SOA might not be problematic
today. For example, today it is a lot easier to automate deployments and
automate monitoring. The devops and "infrastructure as code" movements
have produced many tools that make it significantly easier than before
to orchestrate distributed systems with multiple moving parts.

The marketplace itself could work in a similar way that npm, gem or
the Docker registry work. There could be open source or paid
microservices.

I could see such a marketplace taking market share out of services that
are operated by third parties (e.g. MailChimp, Disqus, UserVoice,
Mashape, etc.).

# 10. Module/Package/Library Search Engine

<img class="img-rounded" src="/images/npm.png" align="right">

Most package repositories ([npm](https://www.npmjs.com/),
[gems](https://rubygems.org/search), [PyPi[(https://pypi.python.org))
don't get search quite right. Most developers prefer to head directly to
Github and pick libraries according to their starts count.

I'm sure we can do better than that. What if there was a library search
engine that could find the best possible library given a language and a
few key words?

Some signals that could be used to rank libraries in search results:

- Code quality metrics
- Github stars count
- Creation data, recent commits
- Authors
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
we have in the hacker/startup world are "one off" or "once a year"
online hackatons. What if there was a league for hackers and founders
that would operate similarly to how gaming leagues operate?

The idea would be to build a "MVP league" that would combine aspects
of eSports leagues and online hackatons (e.g. [Node Knockout](nodeknockout.com)).

Participants could form teams and submit a new MVP every X weeks.
Another option would be to have theme/technology based tournaments (e.g.
"open source", "Node.js", "education").

Winners could be selected after each cycle, new teams could be formed,
there could be a leader board of teams/participants, etc. Sponsors could
offer prizes to winners or investors could offer funding.

Additionally, this would be a great way to meet potential co-founders
and socialize with like minded peers.

There are already a couple of websites that aggregate online hackatons
([ChallengePost](http://challengepost.com),
[WeHack.it](http://www.wehack.it/)) but I haven't seen one
that operates as a league.

# 12. Code as a Service

<img src="/images/tdd.png" class="img-rounded" align="right">

The idea is about taking Test Driven Development to its limit.

The service would allow developers to write a series of test that must
pass and wait for someone to write the code that passes those tests.

Money/karma would be automatically awarded to the first person who
successfully submits code which passes the tests.

The biggest problems with this idea are:

- In many cases it would be easy to "game" the tests Most developers
- don't have a budget for this or don't know how to
    price the code they need.
- Sometimes writing the tests is as difficult or as time consuming as
    actually writing the code.

# 13. A GUI interface for fig.sh and other similar tools

<img src="https://juju.ubuntu.com/wp-content/uploads/2013/10/homepage-hero.png" class="img-rounded" align="right">

Allow devops and sysadmins to visualize and orchestrate their system
infrastructure through a simple GUI. Logical services could be
represented as squares on a canvas and services that depend on each
others (that need to communicate) could be linked with lines. After
editing the schema, the tool could write the systems specifications in a
text file.

The tool could support
[fig.yml](http://www.fig.sh), [TerraForm](https://www.terraform.io/),
[Kubernetes](http://kubernetes.io),
[BOSH](http://docs.cloudfoundry.org/bosh/) or
[Vagrant](http://www.vagrantup.com) for example.

[Ubuntu Juju](https://juju.ubuntu.com/) is a tool that does something
along those lines although I don't think it can read/write to a
configuration file such as `fig.yml` which is not ideal you adhere to
the [infrastructure as
code](http://devops.com/blogs/meet-infrastructure-code/) philosophy and
want to keep your infrastructure under version control in a Git repository.

# 14. Hosted Open Source Software as a Service

<img src="/images/opensource.png" class="img-rounded" align="right">

This is not really a specific startup idea but a general business model
that is not especially novel either.

There is a lot of open source software out there that can be hard to
install or operate for the average consumer or even for some developers
with minimal sysadmin experience.

The general idea is to pick an open source software, completely automate
its deployment and sell it as a paid service. In other words, SaaSifying
open source projects.

You can then put up a simple promotional website where people can sign
up and pay a monthly fee for you to host the software for them.

Obviously, most well known open source software (e.g. Wordpress) already
have tons of [companies](http://www.wordpress.com) doing this but some
more obscure software might not yet have such services available on the
market.

# Conclusion

Hope you liked my crazy shower ideas. Let me know if you plan to borrow
one! I'd also be curious to hear about some more crazy ideas in the
comments if you have any.

