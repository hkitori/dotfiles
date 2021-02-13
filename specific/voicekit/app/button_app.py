#!/usr/bin/env python3

import os
#import time
import pygame.mixer

from aiy.board import Board, Led
from aiy.leds import Leds, Color, Pattern

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
    pygame.mixer.init()
    cl=0
    song=0

    tmp = absoluteFilePaths(dir_path)
    SONGS = sorted(tmp)

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
                print('pressed! play')

                pygame.mixer.music.load("/home/pi/dotfiles/specific/voicekit/app/play.mp3")
                pygame.mixer.music.play(1)

                #board.led.state = Led.ON
                leds.update(Leds.rgb_on(COLORS[cl]))


                ###########
                # release #
                ###########
                board.button.wait_for_release()
                print('released!')

                leds.pattern = Pattern.breathe(800)
                leds.update(Leds.rgb_pattern(COLORS[cl]))

                pygame.mixer.music.load(SONGS[song])
                pygame.mixer.music.play(1)


                ###########
                # press   #
                ###########
                board.button.wait_for_press()
                print('pressed! stop')

                #board.led.state = Led.ON
                leds.update(Leds.rgb_on(COLORS[cl]))

                pygame.mixer.music.load("/home/pi/dotfiles/specific/voicekit/app/stop.mp3")
                pygame.mixer.music.play(1)


                ###########
                # release #
                ###########
                board.button.wait_for_release()
                print('released!')

                pygame.mixer.music.stop()
                #board.led.state = Led.OFF
                leds.update(Leds.rgb_off())

                # for next loop
                if song < len(SONGS)-1 :
                    song+=1
                else :
                    song=0

                if cl < len(COLORS)-1 :
                    cl+=1
                else :
                    cl=0

                continue

if __name__ == '__main__':
    main()
