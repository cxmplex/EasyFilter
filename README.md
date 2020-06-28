# EasyFilter
Wow chat filtering addon that supports regex

**Original Thread**:

https://www.reddit.com/r/wow/comments/hgznc8/i_made_a_simple_lightweight_chat_filtering_addon/

**How to Use?**

* **Add a filter:**
 * **EVERYTHING IS IN LOWERCASE.** Always make the filter in lower-case, I automatically lowercase all chat.
 * Filters support basic regex or full lua pattern matching. You can more about Lua's pattern matching [here](https://www.lua.org/pil/20.2.html).
 * You can add a filter using the add command `/ef add filter`

 * Examples:
     * `/ef add gallywix.+boosting` "Gallywix is providing Boosting"
     * `/ef add gold%s+only` "Selling boost. gold only"
     * `/ef add wts.+mythic%s%d+` "WTS Mythic 10"

* **Remove a filter:**
   * `/ef del filter`

* **Enable preset filters:**
   * `/ef enablepreset filterName` currently only "boosting" is available
    * `/ef enablepreset boosting` will block most boosting posts

* **Available Filter Presets:**

 * `boosting` - Blocks most boosting related posts `/ef enablepreset boosting`


 * `twitch` - Blocks twitch related posts (stream advertisers) `/ef enablepreset twitch`


 * `lang` - Blocks all Asian languages (Japanese, Chinese, Korean) `/ef enablepreset lang`

**MOST OF YOU WILL WANT TO ENABLE THE BOOSTING FILTER! READ ABOVE**

* **Delete a filter:**
    * `/ef disablepreset filterName`

* **Disable "Blocking" Notification:**
    * `/ef silence`

* **Clear enabled-presets & user defined filters**
    * `/ef clear`
