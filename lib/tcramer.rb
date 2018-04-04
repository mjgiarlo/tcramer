# frozen_string_literal: true

require 'tcramer/engine'
Kernel.silence_warnings do
  require 'zalgo'
end

# Tcramer writes rake tasks!
module Tcramer
  ISMS = [
    'Why not?',
    'Mandatory fun!',
    'Agile groove',
    '🐹',
    "That's a great question, what do YOU think?",
    "What's your opinion of walruses?",
    'How soon before this is ready for production?',
    'Okay, but if you did have a spec, how long would it take?',
    '(entering a room) dun dun DUN',
    'Nailed it!',
    'Uh oh.',
    'Typed with my thumbs.',
    'Could you give a 5 minute demo on that?',
    'That was an interesting choice.',
    'APIs! APIs! APIs!',
    'The reward for good work is more work.',
    %{
                   __ ___'
                 .'. -- . '.
                /U)  __   (O|
               /.'  ()()   '.\\._
             .',/;,_.--._.;;) . '--..__
            /  ,///|.__.|.\\\\\\  \\ '.  '.''---..___
           /'._ '' ||  ||  '' _'\\  :   \\   '   . '.
          /        ||  ||        '.,    )   )   :  \\
         :'-.__ _  ||  ||   _ __.' _\\_ .'  '   '   ,)
         (          '  |'        ( __= ___..-._ ( (.\\
         ('\\      .___ ___.      /'.___=          \\.\\.\\
         \\\\\\-..____________..-''
    },
    %(It's not just good; it's good ENOUGH.)
  ].freeze

  # rubocop:disable Metrics/LineLength
  FACE = %(
    [0;37;40m                                                            [0m
    [0;37;40m                      [0;1;30;47m  [0;1;37;47m8[0;5;37;47mX@[0;1;37;47mS[0;1;30;47mt[0;5;37;47m8;[0;1;37;47m%[0;1;30;47m:[0;1;37;47m8[0;5;37;47mt%@8[0;1;37;47mS[0;1;30;47m [0;37;40m                    [0m
    [0;37;40m               [0;1;30;47m.[0;1;37;47m:[0;1;30;47m;t[0;1;37;47m@t8[0;5;37;47m;;;8%S[0;1;30;47m;[0;1;37;47m.[0;5;37;47m88%@.[0;1;30;47m.[0;1;37;47m:[0;5;37;47m@tS[0;1;30;47m;[0;37;40m                   [0m
    [0;37;40m              [0;1;30;47m%[0;1;37;47m8S:[0;1;30;47mS[0;5;35;40mSt%[0;1;30;47m8@[0;5;35;40m;S[0;5;36;40m;[0;1;30;47m8[0;35;47m8[0;5;37;40m@[0;34;45m8[0;5;35;40m%%S [0;1;30;47mX[0;5;35;40m8[0;1;30;47m8[0;5;35;40m.[0;5;34;40m8[0;5;35;40m.[0;1;30;47m:88[0;37;40m                [0m
    [0;37;40m           [0;1;30;47m [0;1;37;47m;;[0;34;40mX[0;5;35;40m [0;1;30;47m [0;5;35;40m8[0;31;40m%[0;5;34;40m@[0;31;40mX[0;34;40mS[0;5;35;40m8[0;1;37;47mXt[0;1;30;47m8[0;1;30;44m8[0;5;34;40mXX[0;1;30;47mt[0;5;37;47m%[0;1;30;47m:t[0;5;35;40m [0;30;44m8[0;34;40mX[0;1;30;40m8[0;5;34;40mX[0;5;35;40m8[0;34;40mS[0;5;30;40mS[0;1;30;40m8[0;5;35;40m% [0;1;30;47m@[0;1;37;47m8[0;1;30;47mt[0;5;36;40m [0;37;40m            [0m
    [0;37;40m        [0;5;37;40m8[0;1;30;47mX[0;1;37;47m%8[0;5;37;47mt[0;1;37;47mS[0;31;40m8[0;5;35;40mX[0;1;37;47mS[0;5;37;47mX[0;5;35;40mt[0;31;40m%[0;34;40m;[0;31;40mt[0;1;37;47m:[0;5;37;47m;:S[0;5;35;40m.. [0;1;30;45m8[0;5;35;40mt[0;34;40m8[0;5;35;40m8[0;5;37;40m8[0;5;35;40m:.[0;1;30;47mX[0;5;34;40m@[0;31;40m%[0;5;35;40mX[0;5;30;40mX[0;1;30;40m8[0;34;40mX[0;31;40mS[0;34;40mX[0;5;37;40m8[0;1;30;47m%[0;1;37;47mS[0;1;30;47mS[0;5;35;40m.[0;5;36;40m.[0;37;40m         [0m
    [0;37;40m        [0;5;31;40m@[0;5;35;40mXX[0;1;37;47mS[0;5;37;47mt[0;1;35;47mS[0;5;35;40m@[0;5;34;40mS[0;5;35;40mX[0;5;37;40m8[0;1;30;47m;[0;5;35;40m@[0;32;40m:[0;34;40m:[0;5;30;40mX[0;1;30;47m [0;5;35;40m8[0;34;40m%[0;31;40mX[0;34;40mS[0;31;40mX[0;1;30;40m8[0;5;37;40m8[0;1;30;47mX[0;5;37;40m8[0;1;30;47mt[0;5;35;40mS8[0;31;40mX[0;1;30;40m8[0;5;35;40m [0;5;37;47mt[0;1;37;47m8[0;5;35;40m8[0;31;40m.[0;34;40m.[0;31;40m:[0;34;40m.[0;5;35;40mS[0;1;37;47m;[0;5;37;47m%[0;1;30;47m%X[0;5;35;40m [0;37;40m        [0m
    [0;37;40m       [0;1;30;47m;S[0;31;40m;[0;5;30;40m8[0;1;30;47mt[0;35;47m8[0;1;30;47m@[0;31;40mS[0;34;40m:[0;31;40m:[0;34;40m.[0;31;40m... :[0;34;40m:[0;31;40m:.[0;34;40m:[0;31;40m:[0;34;40m;t[0;5;35;40mX[0;1;30;40mX[0;31;40mtt[0;5;30;40m@[0;34;40mtt[0;31;40m%[0;34;40m@[0;5;35;40mt[0;1;30;40m8[0;34;40m.[0;31;40m.[0;34;40m [0;31;40m [0;34;40m [0;5;30;40m8[0;1;37;47m%[0;5;37;47m:..@[0;5;35;40mX[0;5;37;40m8[0;37;40m      [0m
    [0;37;40m      [0;5;37;40m8[0;5;37;47mtX[0;5;35;40mX[0;31;40m:tt[0;34;40m;:[0;31;40m.[0;34;40m.[0;31;40m.[0;34;40m  .[0;31;40m.t[0;1;30;40m88[0;5;31;40m@[0;34;40mt[0;31;40m::[0;32;40m.[0;31;40m..[0;34;40m..[0;31;40m.;[0;1;30;40mS[0;5;30;40m8[0;31;40m8[0;34;40m%[0;31;40mt[0;34;40m:[0;31;40m.[0;34;40m  :[0;5;35;40m.[0;1;37;47mX[0;1;30;47mt[0;1;37;47m   [0;5;37;40mS[0;5;34;40mS[0;37;40m      [0m
    [0;37;40m     [0;1;30;47m;[0;5;37;47mS@[0;31;40mS[0;34;40mt[0;31;40m.[0;34;40m..[0;31;40mt[0;1;30;40m@[0;1;30;41m8[0;31;40m@X8[0;5;31;40m8[0;31;40m@[0;34;40m;:[0;31;40mS[0;34;40mS[0;31;40mtttt;;t[0;34;40m:[0;31;40m.[0;32;40m.[0;34;40m.[0;31;40m.[0;34;40m%[0;1;30;40m@[0;31;40mX[0;1;30;40m@[0;5;30;40m8[0;5;35;40m%.[0;31;40mX[0;34;40mt[0;5;35;40mt8[0;34;40mS8[0;30;44m8[0;5;35;40m8X[0;5;34;40mS[0;1;30;40mX[0;5;36;40m;[0;37;40m    [0m
    [0;37;40m    [0;5;37;40mX[0;5;37;47mS:[0;1;30;47mt[0;31;40m;[0;34;40m.[0;31;40mS[0;34;40m.[0;5;31;40m8[0;1;37;47m [0;5;37;47m8[0;1;37;47m      [0;1;31;47m8[0;5;37;40m:[0;5;31;40mX[0;1;30;41mX[0;31;40mt[0;34;40m;[0;31;40m%St[0;34;40m:[0;32;40m:[0;31;40m.[0;34;40m.[0;32;40m  [0;31;40m.:[0;32;40m:[0;34;40m:[0;31;40m;S[0;5;30;40m8[0;5;31;40mS[0;1;30;40mX[0;31;40m.[0;34;40m .[0;31;40m%%;[0;1;30;40m8[0;5;35;40m%[0;5;30;40m@[0;1;30;40m8[0;5;34;40m8[0;37;40m    [0m
    [0;37;40m    [0;1;30;47m.[0;5;37;47mt[0;1;37;47m@[0;1;30;45mS[0;31;40mt[0;34;40m.[0;31;40mX[0;5;35;40m8[0;1;30;47m8[0;5;37;47m88S%t;%%;%88[0;1;37;47m  [0;1;30;47m88[0;1;31;43m8[0;5;35;40m:S[0;1;30;41m@[0;5;31;40m8[0;5;30;40m8[0;31;40mt[0;32;40m.[0;34;40m.[0;31;40m.[0;34;40m.[0;31;40mt[0;34;40m:[0;31;40m:[0;34;40m    .::.[0;5;35;40mX[0;1;30;47m:[0;1;37;47m;[0;5;35;40m8[0;32;40m:[0;5;30;40mS[0;37;40m   [0m
    [0;37;40m    [0;1;37;47mt[0;1;30;47mX[0;5;35;40mX[0;5;31;40m8[0;31;40m:%[0;5;35;40m:[0;5;37;47m8St;t;;;::::;t;tt: :S8[0;1;33;47mS[0;5;37;41m8[0;35;47m@[0;1;30;41m8[0;31;40mX[0;32;40m.[0;34;40m.[0;31;40m;;:X[0;5;31;40m@[0;31;40mX[0;34;40m:[0;32;40m.[0;31;40m.[0;32;40m.[0;31;40m.[0;5;35;40mt[0;1;37;47mX[0;1;30;47m.[0;5;30;40m8[0;31;40m.[0;1;30;40mX[0;37;40m   [0m
    [0;37;40m    [0;5;37;47mS[0;1;30;47m%[0;5;35;40m8[0;1;30;41mX[0;5;35;40m%[0;1;30;45m8[0;5;37;47m8S::;%XXSXXXSS%t;::.;;%S8[0;1;31;47m@@8[0;1;30;47m8[0;5;35;40m:[0;1;30;47m8[0;35;47mX[0;1;37;47m :[0;5;37;47m8[0;1;37;47m [0;1;35;47mS[0;1;30;41m8[0;31;40m.:[0;1;30;40mX[0;31;40mt[0;5;35;40mXt[0;5;30;40m8[0;34;40m:[0;1;30;40m8[0;5;36;40mt[0;37;40m  [0m
    [0;37;40m    [0;1;37;47m@[0;5;35;40mS[0;31;40m8[0;5;35;40m%[0;1;30;47m8[0;5;37;47m8S:%@888888888888888888XSXS888@X888X%S8[0;5;35;40m8[0;31;40mS[0;1;30;40mXX[0;34;40m.[0;31;40m.[0;34;40m.[0;31;40m;[0;5;30;40m@[0;37;40m   [0m
    [0;37;40m   [0;5;36;40m [0;5;31;40mS[0;31;40m%@[0;5;35;40m;[0;5;37;47m8S.:888[0;5;1;35;47mX[0;5;1;33;47mX[0;5;1;35;47m@[0;5;1;33;47mX[0;5;1;35;47m@[0;5;1;33;47m@[0;5;1;35;47m@[0;5;1;33;47m@[0;5;1;35;47m@[0;5;1;33;47mX[0;5;1;35;47m@[0;5;37;47m88888[0;5;1;35;47m@[0;5;37;47m888SX8@S@[0;5;1;35;47m@[0;5;37;47m8[0;5;1;35;47m8[0;5;37;47m88;t[0;1;37;47m.[0;1;30;41m8[0;31;40m;[0;34;40m..[0;32;40m.[0;31;40m.[0;34;40m;[0;5;33;40m:[0;37;40m   [0m
    [0;37;40m  [0;5;37;40m8[0;5;36;40m:[0;5;30;40m8[0;34;40m:[0;31;40m%[0;5;35;40m:[0;5;37;47mX.:%8[0;5;1;33;47mX[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m@[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;1;33;47m@[0;5;1;35;47m8[0;5;37;47m88[0;5;1;35;47mS[0;5;37;47m8[0;5;1;35;47m@[0;5;1;33;47m@[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;37;47mX.;[0;1;35;47mX[0;31;40m8[0;32;40m.[0;31;40m.[0;34;40m [0;32;40m.[0;31;40m:[0;5;36;40m%[0;37;40m   [0m
    [0;37;40m  [0;5;33;40m [0;1;30;47mX[0;5;35;40m.[0;31;40m8%[0;35;47m8[0;5;37;47m8t;88[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;31;45m8[0;5;37;47m88[0;5;1;37;45m8[0;5;1;33;47m8[0;5;37;47m8:%8[0;1;30;41m8[0;31;40m;[0;32;40m.[0;34;40m.[0;31;40m.;[0;5;36;40m@[0;37;40m   [0m
    [0;37;40m [0;5;36;40m;[0;5;37;40m8[0;1;30;41m8[0;34;40m%[0;1;30;41m8[0;31;40mS[0;1;31;47m8[0;5;37;47m8Xt8[0;5;1;33;47m@[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;37;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;37;47m888[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;37;47m888[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m@[0;5;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;31;43m8[0;5;37;47m8[0;5;1;37;45m8[0;5;37;47m88%8[0;5;35;40m;[0;31;40m@ [0;32;40m.[0;34;40m:[0;31;40mt[0;5;36;40mX[0;37;40m   [0m
    [0;37;40m  [0;5;35;40m :[0;5;31;40mS[0;31;40mX8[0;37;45m8[0;5;37;47m8XX8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;1;33;47m%[0;5;37;47m8[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;37;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;37;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;37;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;35;47mX[0;5;37;47m88[0;1;31;41m8[0;32;40m:[0;34;40m.[0;31;40m:[0;32;40m;[0;1;30;40mX[0;5;36;40m8[0;37;40m   [0m
    [0;37;40m  [0;5;35;40m.XSS[0;30;41m@[0;5;33;41mS[0;5;37;47m8S8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;37;47m8888[0;5;1;35;47m8[0;5;1;33;47m@[0;5;1;35;47m8[0;5;37;47m88888[0;5;1;35;47m@[0;5;1;33;47m@[0;5;1;35;47m8[0;5;37;47m8[0;5;1;33;47m@[0;5;37;47m888[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;37;47m8[0;5;1;35;41m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;37;43m8[0;1;30;45mX[0;31;40mt.%[0;5;30;40m8[0;31;40mX[0;5;36;40mX[0;37;40m   [0m
    [0;37;40m  [0;5;35;40m:[0;5;31;40m8[0;31;40m88[0;1;30;41m@[0;5;37;40mS[0;5;37;47m88[0;5;1;33;47m@[0;5;1;37;45m8[0;5;1;37;43m@[0;5;1;37;45m8[0;5;1;33;47m8[0;5;37;47m888888[0;5;1;35;47mS[0;5;1;33;47mX[0;5;1;35;47m@[0;5;1;33;47m@[0;5;37;47m888[0;5;1;35;47m8[0;5;1;33;47m@[0;5;1;35;47m8[0;5;37;47m88888[0;5;1;35;47mX[0;5;37;47m888888[0;5;1;33;47m@[0;5;37;47m8[0;5;1;35;41m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;1;31;47m8[0;31;40mt[0;32;40m:[0;34;40m:[0;31;40mt[0;1;30;40m8[0;5;36;40m.[0;37;40m   [0m
    [0;37;40m  [0;1;30;47m.[0;31;40m8[0;34;40m%[0;32;40m;[0;1;30;41m@[0;1;35;47m%[0;5;37;47mS8[0;5;1;35;47m@[0;5;1;37;43m8[0;5;1;35;47m8[0;5;37;47mX8%%tt;SX88[0;5;1;35;47mX[0;5;37;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;37;47m8[0;5;1;35;47mX[0;5;37;47m888[0;5;1;35;47mS[0;5;37;47m88St;%SX%[0;5;1;35;47m%[0;5;37;47mS%8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;37;47m8[0;1;37;47m [0;1;30;41m8[0;31;40m;[0;32;40m:[0;34;40m:[0;5;31;40m8[0;1;37;47mX@[0;1;30;47mt[0;37;40m [0m
    [0;37;40m [0;1;37;47mS[0;5;37;47m.[0;1;37;47m:[0;1;30;41mt[0;31;40m:[0;1;30;41m8[0;5;37;47m88@88@S8[0;5;1;35;41m@[0;5;37;41m8[0;1;37;47m [0;5;1;35;41m8[0;5;37;47m8[0;5;1;35;41m8[0;5;37;47m@88[0;5;1;33;47mS[0;5;37;47m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;37;47m8[0;5;1;33;47mS[0;5;1;35;47mX[0;5;1;33;47m@[0;5;1;35;47m@[0;5;1;33;47m@[0;5;1;35;47m@[0;5;1;33;47m@[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;31;45m8[0;1;31;47mX[0;5;1;35;41m8[0;1;33;47mS[0;5;1;31;45m8[0;5;37;47m8888[0;5;1;35;47m@[0;5;1;33;47m8[0;5;37;47m88[0;5;35;41mS[0;32;40mS[0;34;40m;[0;31;40m@[0;1;37;47m@:[0;1;30;45m8[0;33;47m8[0;37;40m [0m
    [0;37;40m [0;1;30;47m [0;5;37;47m%;[0;1;37;47mX[0;35;41mX[0;1;31;41m8[0;5;37;47m8XX8@[0;5;1;33;47mX[0;5;31;41m t[0;33;41m@[0;1;31;41m88[0;33;41m@[0;30;41m%[0;33;41m8[0;30;41m%[0;1;31;41mX[0;5;35;41m.[0;1;37;47m [0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;31;43m@[0;5;1;35;47m8[0;5;1;31;43m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;31;45m8[0;5;1;33;41m8[0;5;31;41m@[0;30;41mt888[0;1;30;41m8[0;30;41mX[0;33;41m8[0;1;31;41mS[0;5;31;41mX[0;5;37;41m8[0;5;37;47m88XSX[0;1;35;47mS[0;31;40mt[0;32;40m.[0;1;30;47m%[0;5;37;47m8[0;5;35;41m.[0;35;41mX[0;1;37;47m [0;37;40m [0m
    [0;37;40m  [0;5;37;47mS;:[0;1;37;47mS[0;1;31;47m8[0;5;37;47m8@8X8[0;5;1;35;47mS[0;5;37;41m8[0;1;37;47m [0;5;35;41m [0;5;31;40mX[0;30;41mX[0;31;40mS[0;32;40m:[0;34;40m.[0;32;40m.;[0;1;30;41mS[0;5;31;41m [0;5;1;33;41m8[0;5;37;45m8[0;5;1;37;43m8[0;5;1;31;45m8[0;5;1;33;41m8[0;5;1;35;41m8[0;5;1;33;41m8[0;5;1;31;45m8[0;5;1;31;43m8[0;31;45m@[0;31;40m%[0;34;40m:.[0;32;40m::.[0;31;40m8S8[0;5;35;40mX[0;1;31;41m8[0;1;31;47m8[0;5;37;47mXt[0;5;1;35;47mS[0;5;37;47m8[0;1;37;47m [0;30;41m@[0;1;30;47m8[0;5;37;47m@. 8X[0;37;40m [0m
    [0;37;40m  [0;5;37;47m;;S%S88[0;5;1;33;47mX[0;5;1;35;47mS[0;5;1;33;47m%[0;5;37;47m8[0;5;1;33;47m8[0;5;1;35;41m8[0;5;33;41m:[0;5;33;40mS[0;1;30;47m88[0;30;41mX[0;31;40mS[0;34;40m;[0;5;35;40m%[0;1;30;41mt[0;31;45m8[0;5;37;41m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m@[0;5;37;47mt8[0;1;37;47m [0;5;1;33;41mX[0;31;45m@[0;31;40m8[0;32;40m:[0;1;30;41m@[0;31;40mt[0;34;40m:[0;32;40m.[0;31;40mS[0;5;31;40m@[0;30;41m88[0;5;35;40mt[0;5;37;41m8[0;1;35;47mS[0;5;37;47m88888[0;5;31;41mX[0;5;37;47m8[0;1;35;47m@[0;1;37;47m [0;5;37;47mS.;[0;37;40m [0m
    [0;37;40m  [0;5;37;47m:8[0;5;31;41mS[0;33;47m@[0;5;37;47mS8[0;5;1;35;47m8[0;5;1;31;43m8[0;5;1;35;47mS[0;5;37;47m888Xt88X8[0;1;37;47m :[0;5;37;47m8[0;1;37;47m [0;1;33;47mS[0;5;1;37;45m8[0;5;37;43m8[0;5;37;47m8%:t[0;5;1;35;47m8[0;5;37;41m8[0;1;37;47m [0;5;33;41m%[0;1;30;47mt[0;1;37;47m8[0;5;37;47mX[0;1;30;47m88[0;1;37;47mt[0;5;37;47mX[0;1;37;47m%  [0;5;37;47m888[0;5;1;35;47mS8[0;5;1;33;41m@[0;5;37;45m8[0;5;37;47m8[0;5;37;41m8[0;5;31;41m%[0;1;31;41m@[0;1;35;47m8[0;5;37;47mSt[0;37;40m [0m
    [0;37;40m  [0;5;37;47m:[0;1;37;47m;[0;5;35;41m [0;5;37;47m;%8[0;5;1;33;41m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;1;35;47m@[0;5;1;33;47mS[0;5;37;47m88X88[0;5;37;41m8[0;1;37;47m [0;1;35;47m@[0;5;1;33;41m8[0;5;1;31;45m8[0;5;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;37;47m8X[0;5;1;35;47mS[0;5;37;47m88[0;5;1;35;41m8[0;5;37;47m88[0;1;37;47m.[0;5;37;47m8[0;1;35;47m%[0;1;37;47m   [0;5;37;47m888@XS@8[0;5;1;33;41m8[0;5;37;45m8[0;5;1;33;41m8[0;5;37;47mX [0;1;37;47m%[0;5;1;35;41m@[0;1;37;47m [0;5;37;47mt%[0;37;40m [0m
    [0;37;40m  [0;5;37;47m. t;X8[0;5;1;37;45m8[0;5;1;33;41m8[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;37;47m888[0;5;1;35;47m8[0;5;1;31;43m8[0;5;1;37;45m8[0;5;1;33;41m8[0;1;37;47m [0;5;37;47m88[0;5;1;35;47m@[0;5;1;33;47m@[0;5;1;35;47m8[0;5;37;47m8[0;5;1;35;47m@[0;5;37;47m8@[0;5;1;35;47m@[0;5;1;33;41m8[0;5;1;35;47m8[0;5;1;33;41m@[0;5;1;35;47m8[0;5;37;47m8[0;5;1;35;47m8[0;5;37;47m8[0;5;1;33;47m8[0;5;1;35;41m8[0;5;1;33;41m8[0;5;37;45m8[0;5;37;47m88[0;5;1;35;47mS[0;5;37;47m8[0;5;1;35;47mX[0;5;1;33;47mX[0;5;1;35;47m@[0;5;1;35;41m8[0;5;1;33;41m8[0;5;37;41m8[0;5;37;47m8;X88:8[0;37;40m [0m
    [0;37;40m  [0;5;37;47m.::;88[0;5;1;33;41m8[0;5;1;35;47m8[0;5;1;33;41m8[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;37;47m8;S [0;5;1;35;47m@[0;5;37;47m888[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;35;47mX[0;5;37;47mX:[0;5;1;37;45m@[0;5;1;33;41mS[0;5;37;45m8[0;5;1;33;41m8[0;5;1;35;47m8[0;5;37;47m8[0;5;1;35;47m@[0;5;37;47m8. 8888[0;5;1;35;47mS[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;41mX[0;5;35;41mXX[0;5;37;47m88[0;5;37;45m8[0;5;37;47m8;.8[0;37;40m [0m
    [0;37;40m  [0;1;37;47m@[0;5;37;47m .;8[0;5;1;37;45m8[0;5;1;31;43m8[0;5;37;45m8[0;5;37;43m8[0;5;1;31;45m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;37;47m88[0;5;1;35;47mS[0;5;37;47m88[0;5;1;35;47mS[0;5;37;47m8[0;5;1;35;47mX[0;5;1;33;47m8[0;5;37;45m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;37;47m@:[0;5;1;35;47m8[0;5;1;35;41m8[0;5;37;47m8[0;5;1;35;41m8[0;5;37;47m8[0;5;1;31;45m8[0;5;1;33;47mX[0;5;37;47m8[0;5;1;35;47mS[0;5;37;47m@t[0;5;1;35;47mS[0;5;37;47m8[0;5;1;35;47mt[0;5;37;47m8[0;5;1;35;47m8[0;5;1;33;41m8[0;5;1;35;47m8[0;5;1;33;41mX[0;5;37;41m8[0;5;33;40mS[0;5;31;41m8[0;1;35;47mS[0;5;37;47m88%.:[0;1;37;47m:[0;37;40m [0m
    [0;37;40m   [0;5;37;47m;.t88[0;5;1;33;47m8[0;5;1;35;41m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;31;43m8[0;5;37;47m8[0;5;1;31;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m@[0;5;1;35;47mX[0;5;37;47m8S8[0;5;1;35;41m8[0;5;1;33;41m8[0;5;37;45m8[0;5;37;47m@@%.t8[0;5;1;35;47m8[0;5;1;33;41m8[0;5;1;35;47m@[0;5;37;47m8[0;5;37;41m8[0;5;37;45m8[0;5;37;47m88;[0;5;1;35;47mS[0;5;37;47m8[0;5;1;35;47mS[0;5;37;47m8[0;5;1;33;47m8[0;5;1;31;45m8[0;5;37;47m8[0;5;1;37;43m8[0;5;1;31;45m@[0;5;33;41m.[0;5;35;40mt[0;5;31;41m@[0;1;31;47mS[0;5;37;47m88;S8[0;37;40m  [0m
    [0;37;40m   [0;1;37;47m%[0;5;37;47m;;%@8[0;5;1;33;47m8[0;5;1;35;41m8[0;5;1;37;43m8[0;5;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;1;31;43m8[0;5;1;35;47m8[0;5;37;47m88[0;5;1;35;47mX[0;5;1;33;47m8[0;5;1;35;41mS[0;5;31;41m 8[0;5;37;47m8t:..:S%[0;5;1;35;47m%[0;5;37;47m%t8[0;5;31;41mt[0;5;37;41m@[0;5;37;47m8[0;5;1;35;47mS[0;5;37;47m88[0;5;1;35;47m8[0;5;1;33;41m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;31;45m@[0;5;37;47m8[0;5;1;33;41m8[0;35;47m8[0;5;33;41m%[0;1;30;47m8[0;5;37;47m888[0;5;1;35;47m8[0;33;47mX[0;37;40m   [0m
    [0;37;40m      [0;1;37;47m@[0;5;37;47m8S@8[0;5;1;35;41m8[0;5;1;37;43m8[0;5;1;35;41m8[0;5;1;33;47m8[0;5;1;37;45m8[0;5;37;43m8[0;5;1;37;45m8[0;5;1;31;43m8[0;5;1;31;45m8[0;5;31;41m ;[0;33;47m8[0;1;35;47mS[0;5;37;47m8[0;5;1;31;45m8[0;5;37;47m88[0;5;1;35;47m8[0;5;37;47m8[0;5;1;35;47m@[0;5;37;47m8[0;5;1;35;47mX[0;5;37;47m8[0;5;1;35;47m8[0;1;37;47m [0;5;31;41m [0;5;37;41m8[0;5;1;31;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;31;45m8[0;5;1;33;47m@[0;5;1;35;41m8[0;5;1;33;47m8[0;5;1;35;41m8[0;5;37;47m8[0;5;1;35;41m@[0;1;33;47mX[0;1;37;47m [0;1;35;47mS[0;1;37;47m [0;1;35;47m%[0;37;40m      [0m
    [0;37;40m        [0;1;37;47m8[0;5;37;47mt X[0;5;37;43m8[0;5;1;31;45m8[0;5;37;43m8[0;5;1;37;45m8[0;5;1;31;43m8[0;5;1;35;47m8[0;5;1;33;41mS[0;5;31;41m [0;5;33;41m;[0;1;37;47m%[0;5;37;47mS@88[0;5;1;35;41mX[0;5;1;31;43m8[0;5;1;35;41mSS[0;1;33;47mX[0;5;1;35;41mX[0;5;31;41mt[0;1;31;41mX[0;5;37;41m8[0;5;37;47m8@8[0;5;1;33;41m@[0;5;1;35;41m8[0;5;1;33;41mX[0;5;1;35;41m8[0;5;1;37;43m8[0;5;1;31;45m8[0;5;1;37;43m8[0;5;1;35;41m@[0;5;1;33;41m8[0;5;37;41m8[0;1;37;47m [0;5;37;47m88[0;5;37;41m8[0;37;40m        [0m
    [0;37;40m         [0;5;37;47mt:X8[0;5;1;31;43m8[0;5;1;37;45m8[0;5;37;43m8[0;5;1;35;47m8[0;5;1;33;41mS[0;5;31;41m%[0;35;47m@[0;5;37;47m8S.:%@ [0;5;1;35;47m8[0;5;31;41m [0;33;41m%[0;35;41m.[0;30;41m8[0;5;31;40m8[0;1;37;47m [0;5;37;47m8[0;5;1;35;47m8[0;5;37;47m8[0;5;1;35;47mX[0;5;37;47m8[0;5;1;35;41m@[0;1;37;47m [0;5;1;33;41mX[0;5;31;41m%[0;5;37;41m8[0;5;1;35;41m8[0;1;33;47m@[0;5;35;41m [0;1;35;47mS[0;5;37;47m88[0;5;37;41m8[0;37;40m         [0m
    [0;37;40m         [0;1;37;47m8[0;5;37;47m.t[0;5;1;33;47m8[0;5;37;45m8[0;5;1;31;43mX[0;5;37;47m8[0;5;1;33;41m8[0;5;35;41m:[0;1;37;47m  [0;5;37;47m8[0;5;1;35;47m@[0;5;37;47mS;[0;5;1;35;47mX[0;5;37;47mX[0;5;1;35;47mX[0;5;1;33;41m@[0;5;35;41mS[0;5;35;40m [0;1;35;47m@[0;33;47m@[0;1;35;47mX[0;5;37;47m8[0;5;37;45m8[0;5;37;47m8888[0;5;1;31;43m8[0;5;1;37;45m8[0;1;37;47m [0;5;37;41m8[0;5;33;41m [0;1;37;47m [0;5;37;41m8[0;1;31;47m8S[0;5;37;47m88[0;1;30;47m8[0;37;40m         [0m
    [0;37;40m         [0;1;30;47m:[0;5;37;47mS%8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;1;33;47m@[0;5;1;35;41m8[0;5;1;33;41m8[0;5;1;35;41mX[0;5;37;41m8[0;1;37;47m [0;5;37;45m8[0;5;1;33;47m8[0;5;37;45m8[0;5;37;47m88:%@8888[0;5;1;35;47m@[0;5;37;47m8[0;5;1;35;47m8[0;5;1;35;41mX[0;1;37;47m [0;5;1;33;41m8[0;5;1;37;45m8[0;5;37;43m8[0;1;37;47m.[0;5;37;47m8[0;5;1;35;41m@[0;1;33;47m@[0;5;1;37;45m8[0;5;37;47m8[0;5;37;41m8[0;37;40m          [0m
    [0;37;40m          [0;1;37;47m%[0;5;37;47mtX[0;5;1;33;47m8[0;5;37;41m8[0;5;37;47m8[0;5;1;31;43m8[0;5;37;47m88[0;1;37;47m   [0;5;1;33;41m@[0;5;37;41m8[0;5;31;41m [0;5;33;41mt[0;5;31;41m%@@[0;5;35;41m:;S[0;5;31;41m@@8@X[0;1;31;43m8[0;1;30;47m8[0;5;35;41m [0;1;37;47m [0;5;1;35;41m8[0;5;37;47m@8[0;5;1;33;47m8[0;5;1;35;41m8[0;1;33;47m@[0;5;37;47m88[0;1;31;47m@[0;37;40m          [0m
    [0;37;40m           [0;1;37;47m@[0;5;37;47mXX8[0;5;1;31;43m8[0;5;1;35;47m8[0;5;1;33;41m8[0;5;1;35;47m8[0;5;1;31;43m8[0;5;1;35;47mX[0;5;37;47m8%%;;;:.::;;%8[0;1;37;47m8[0;5;37;47m88X@88[0;5;1;33;47mX[0;5;1;35;47m@[0;5;1;33;41m8[0;1;35;47mX[0;5;37;47m8[0;5;37;41m8[0;1;31;47m8[0;37;40m           [0m
    [0;37;40m            [0;1;37;47m;[0;5;37;47m%t8[0;5;1;33;47m8[0;5;1;31;45m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m@[0;5;1;37;45m8[0;5;1;33;47m8[0;5;1;37;45m8[0;1;37;47m  [0;5;37;47m8[0;5;37;45m8[0;1;37;47m [0;5;37;47m8[0;5;37;45m8[0;5;37;47m8[0;5;37;45m8[0;1;37;47m;[0;5;37;45m8[0;5;1;35;41m@[0;1;31;47m@[0;5;37;45m8[0;5;37;47m8[0;5;1;31;45m8[0;5;1;33;47m8[0;5;1;35;47m8[0;5;1;33;47m8[0;5;37;45m8[0;5;1;33;41m8[0;5;37;47m88[0;1;37;47m [0;37;40m            [0m
    [0;37;40m             [0;1;37;47m%[0;5;37;47m%88[0;5;1;33;47m@[0;5;1;35;47m8[0;5;37;43m8[0;5;1;35;47m8[0;5;1;37;43m8[0;5;1;37;45m8[0;5;1;37;43m8[0;5;1;35;47m8[0;5;1;33;41m8[0;5;1;35;41m8[0;5;33;41m [0;5;31;41mt8[0;1;30;41m8[0;1;31;41m88[0;5;31;41m8S[0;1;31;47m@[0;5;37;47m8[0;1;37;47m [0;5;1;33;47m8[0;5;1;35;47m@[0;5;37;47m8[0;5;1;37;43m8[0;5;37;45m8[0;5;37;43m8[0;5;37;47mX8[0;1;35;47m8[0;37;40m             [0m
    [0;37;40m              [0;1;37;47mX[0;5;37;47mtS88888888.8[0;1;37;47m [0;1;31;47mS[0;35;47m@[0;1;31;47m8[0;1;30;47m8[0;1;37;47m :[0;5;37;47m8@8[0;5;1;35;47mS[0;5;37;47m88[0;5;1;35;47m@[0;5;37;47m88[0;5;1;35;47m8[0;1;35;47mS[0;37;40m               [0m
    [0;37;40m               [0;5;37;47m8%;S888888X8@SS;tt;;:t%[0;5;1;35;47m%[0;5;37;47m88[0;5;1;35;47m8[0;5;1;31;43m8[0;1;37;47m [0;37;40m                [0m
    [0;37;40m                 [0;1;37;47m;[0;5;37;47m88SSXX@8[0;5;1;35;47m%[0;5;37;47m888XX@S[0;5;1;35;47mX[0;5;37;47m%;tS[0;5;1;35;47mX[0;5;1;33;41m8[0;5;35;41m.[0;1;37;47m8[0;37;40m                 [0m
    [0;37;40m                   [0;1;30;47m:[0;5;37;47m88t;%X@88[0;5;1;35;47m%[0;5;37;47m8[0;5;1;35;47mS[0;5;37;47m88Xt[0;5;1;35;47mX[0;5;37;47m8[0;5;1;35;41m8[0;1;31;47m8[0;5;35;40m [0;5;37;47m;[0;37;40m                  [0m
    [0;37;40m                     [0;1;30;47m.[0;5;37;47m888[0;5;1;33;47mS[0;5;1;35;47mS[0;5;1;33;47mS[0;5;1;35;47m@[0;5;1;33;47mX[0;5;37;47m88[0;5;1;35;47m8[0;5;37;47m8[0;5;37;45m8[0;1;31;47m8[0;5;37;41m8[0;1;31;47m8[0;1;30;47m:[0;37;40m                     [0m
    [0;37;40m                            [0;1;37;47m; [0;1;35;47mX[0;1;33;47m@[0;37;40m                            [0m
  )
  # rubocop:enable Metrics/LineLength

  def self.manage
    selected_ism = ISMS.sample
    # 80% chance of returning string unzalgoized
    return selected_ism if Kernel.rand(5).positive?
    Zalgo.he_comes(selected_ism)
  end

  def self.motivate
    FACE
  end
end
