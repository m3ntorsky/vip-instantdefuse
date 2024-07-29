
<p align="center">
  <a href="https://github.com/swiftly-solution/vip-core">
    <img src="https://cdn.swiftlycs2.net/swiftly-logo.png" alt="SwiftlyLogo" width="80" height="80">
  </a>

  <h3 align="center">[Swiftly] VIP Instant Defuse</h3>

  <p align="center">
    Allows a VIP to instantly defuse the bomb.
    <br/>
  </p>
</p>

<p align="center">
  <img src="https://img.shields.io/github/downloads/m3ntorsky/vip-instantdefuse/total" alt="Downloads"> 
  <img src="https://img.shields.io/github/contributors/m3ntorsky/vip-instantdefuse?color=dark-green" alt="Contributors">
  <img src="https://img.shields.io/github/issues/m3ntorsky/vip-instantdefuse" alt="Issues">
  <img src="https://img.shields.io/github/license/m3ntorsky/vip-instantdefuse" alt="License">
</p>

---
### Depedency 👀

1. Latest [Swiftly](https://github.com/swiftly-solution/vip-core/releases)
2. Latest [VIPCore](https://github.com/swiftly-solution/vip-core/releases)

> [!WARNING]
> The plugin has been optimized for RAM consumption.
![vip-instantdefuse](https://i.imgur.com/M0JCcpS.png)


---
### Installation 👀

1. Download the newest [release](https://github.com/m3ntorsky/vip-instantdefuse/releases).
2. Everything is drag & drop, so i think you can do it!
3. Setup config in `addons/swiftly/configs/plugins/vip-instantdefuse.json` for example:
```json
{
    "prefix":"[{green}Swiftly{default}]",
    "witout_kit": true,
    "he_threat_check": true,
    "molotov_he_check": true,
    "alive_terrorist_check": true
}
```
4. Setup feature into group in `addons/swiftly/configs/plugins/vips.json` for example:
```json
{
    "groups": [
        {
            "id": "group_1",
            "display_name": "Group 1",
            "features": {
                "health": 110,
                "armor": 110,
                "money": 2500,
                "healthshot": 1,
		"instantdefuse": true
            }
        }
    ],
...
```

### Creating A Pull Request 😃

1. Fork the Project
2. Create your Feature Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

### Have ideas/Found bugs? 💡
Join [Swiftly Discord Server](https://swiftlycs2.net/discord) and send a message in the topic from `📕╎plugins-sharing` of this plugin!

---
