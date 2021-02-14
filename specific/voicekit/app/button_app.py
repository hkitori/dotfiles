#!/usr/bin/env python3

import os
import time
import pygame.mixer

from aiy.board import Board, Led
from aiy.leds import Leds, Color, Pattern

from itertools import cycle

COLORS = (
    #Color.BLACK,
    Color.BLUE,
    Color.CYAN,
    Color.GREEN,
    Color.PURPLE,
    Color.RED,
    Color.WHITE,
    Color.YELLOW,
)

dir_path = '/home/pi/Music/Disney\'s World of English/Play Along! 1/'

def absoluteFilePaths(directory):
    for dirpath,_,filenames in os.walk(directory):
        for f in filenames:
            yield os.path.abspath(os.path.join(dirpath, f))

def main():
    # init
    cl=0
    play=True
    pygame.mixer.init()

    playlist = cycle(sorted(absoluteFilePaths(dir_path)))

    #for songs in playlist:
    #    print(songs)
    #    time.sleep(1)
    #
    #print(next(playlist))

    # use 'sudo alsamixer' commnmd to change speaker volume

    # main loop
    with Board() as board:
        with Leds() as leds:
            leds.update(Leds.rgb_on(COLORS[cl]))
    
            while True:
                ###########
                # press   #
                ###########
                board.button.wait_for_press()
                print('pressed')
                leds.update(Leds.rgb_on(COLORS[cl]))

                if play == True:
                    # press sound at play
                    pygame.mixer.music.load("/home/pi/dotfiles/specific/voicekit/app/play1.mp3")
                    pygame.mixer.music.play(1)

                else:
                    # press sound at stop
                    pygame.mixer.music.load("/home/pi/dotfiles/specific/voicekit/app/stop.mp3")
                    pygame.mixer.music.play(1)

                ###########
                # release #
                ###########
                board.button.wait_for_release()
                print('released')

                if play == True:
                    print('play music!')

                    leds.pattern = Pattern.breathe(800)
                    leds.update(Leds.rgb_pattern(COLORS[cl]))

                    pygame.mixer.music.load(next(playlist))

                    for x in range(50):
                        pygame.mixer.music.queue(next(playlist))

                    pygame.mixer.music.play()

                    play = False

                else:
                    print('stop music!')

                    leds.update(Leds.rgb_off())

                    pygame.mixer.music.stop()

                    play = True

                # for next loop
                if cl < len(COLORS)-1 :
                    cl+=1
                else :
                    cl=0

                continue

if __name__ == '__main__':
    main()

