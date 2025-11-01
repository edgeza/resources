Remember that this resource has verified DMCA protection, and its illegal use or distribution could imply a claim for protection of Title 17 of Chapter 512 (c)(3) of the Digital Millennium Copyright Act.

<figure><img src="https://images.dmca.com/Badges/DMCA_logo-grn-btn200w.png?ID=5ba922b3-b636-4ef4-9637-86a856052338" alt=""><figcaption></figcaption></figure>

## 1. Before starting

Welcome to the Skyclub V3 installation guide, questa risorsa vi permetterá di cambiare al vosto piacimento in game i colori della vostra nuova mappa, therefore you must carefully follow all the steps that you will see in this installation guide.

Please, before opening a ticket in our community, check all the steps of this installation, since the vast majority of tickets are due to ignoring certain steps in the guide. Each step is important and must be respected.


## 2. Asset download

To get started, you'll need to download your new resource previously purchased from [iakko-maps.tebex](https://iakko-maps.tebex.io/). For that we must log in with our account at [`keymaster`](https://keymaster.fivem.net/asset-grants/) and look for the Asset grants section, there we will find our complete package.

Updates will be announced via Changelog in our [`community`](https://discord.gg/tqk3kAEr4f)

## 3. Dependencies

<table><thead><tr><th width="236">Name</th><th>Download link and store</th></tr></thead><tbody><tr><td><code>oxmysql</code></td><td><a href="https://github.com/overextended/oxmysql">https://github.com/overextended/oxmysql</a></td></tr></tbody></table>

## 4. Asset positioning

**READ CAREFULLY!**&#x20;

This step is one of the most important in the documentation, don't skip this.

The Skyclub should always be started after your server's **oxmysql** folder!


It is important to maintain a good order on our server, either in folders or in our cfg file, where we will place the start of our resources.

Make sure you have the correct start order of resources to avoid errors in exports of your framework, if you don't you may receive critical errors.

_Example_

<pre class="language-lua"><code class="lang-lua"><strong>ensure ox_mysql
</strong>ensure iak_skyclub_v3
OTHERS SCRIPTS
</code></pre>

## 5. Database installation

For this step, we always recommend making sure you have the latest version of mysql on your computer or dedicated server, with this we make sure that the import of the sql file works successfully.

The creation of the table on your database will happen automatically, you don't have to do anything!

## 7. Asset configuration

We are already in the final stretch of this installation, so all that remains is to configure the asset to our liking, in config.lua we will find all the necessary configurations explained in **Configuration Page.**

Each section of the configuration includes several explanatory comments, with that you can guide yourself without having to ask for help, since they are very extensive and explanatory.
