# calc-badge-apex
###Calc Badge APEX Plugin

Oracle apex plugin for APEX 5.0 and above.
This plugin alows user to show badge style IOS over the each item defined by jQuery selector.
Plugin creates div or span element based on mentioned object type.
New DIV element is created for input and textarea. For other object types SPAN element is created.

Allowed parameters are:<br>

<b>SQL Query:</b> sql query returns one number value<br>
<b>jQuery selector:</b> Paste jquery selector to the item where you want to show badge<br>
<b>Left:</b> value in pixels (final left position is calculated as width of selected item + Left value)<br>
<b>Top:</b> CSS top style attribute for badge div/span<br>
<b>Page items to submit:</b> Paste items which should be submitted when sql query is executed

## Installation

import file <b>dynamic_action_plugin_user_demovicj_apex_calc_badge.sql</b> to APEX

## Demo Application
https://apex.oracle.com/pls/apex/f?p=69754:3


