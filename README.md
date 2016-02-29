# finty-flush-curses
A recreation of the puzzle game Finty Flush, designed by Alexey Pajitnov, in Ruby with the curses library

Install
=======
  This gem has a dependency on the UTF-8 encoding, so Ruby 1.9 or higher
  is very likely necessary.

  Ensure you have the package "libncursesw5-dev" installed
  `sudo apt-get install libncursesw5-dev` on Ubuntu

  Install the dispel gem if you haven't already
  `gem install dispel`

  Check out the repo as normal
  `git clone https://github.com/KonnorLetterBee/finty-flush-curses`

Usage
=====
  From repo root
  `bin/finty`

TODO
====
  Automatic dropping of new columns over time
  Clearing columns when they're full
  Bonuses and powerups
  Reskin the player's squares
  Better visuals for active player square w/ offset

Author
======
Konnor Nicolau (konnornicolau@gmail.com)