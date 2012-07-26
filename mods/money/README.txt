Minetest 0.4 mod: money
=======================

This can be found in:
  https://github.com/kotolegokot/minetest-mods/money

License of source code
----------------------
Copyright (C) 2012 kotolegokot, Oleg Matveev <gkotolegokot@gmail.com>
See README.txt in each mod directory for information about other authors.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License along
with this program; if not, write to the Free Software Foundation, Inc.,
51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
----------------------




Homepage: http://minetest.net/forum/viewtopic.php?id=2263

Commands for players (requires "money" privilege):
/money — prints the balance of <player>;
/money pay <player> <amount> — it transfers <amount> money to <player>.

Commands for administrators (requires "money_admin" privilege):
/money <player> — prints the balance of <player>;
/money set <player> <amount> — sets the balance of <player> in <amount> money;
/money add <player> <amount> — adds <amount> money to the balance of <player>;
/money dec <player> <amount> — takes off <amount> money from the balance of <player>.

Also, this mod adds shops. To create shop, you should place a locked sign and a locked chest like on the image.
Text, that must be on the locked sign: shopname B/S modname:nodename quantity price. For example: MyShop B default:mese 1 150. The player who punch the sign, buy one mese at a price of 150 money. In the chest must be appropriate items.