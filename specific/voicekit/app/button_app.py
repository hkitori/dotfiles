#!/usr/bin/env python3

#import time
import pygame.mixer

from aiy.board import Board, Led
from aiy.leds import Leds, Color, Pattern

def main():
    # init
    pygame.mixer.init()
    
    # use 'sudo alsamixer' commnmd to change speaker volume

    # main loop
    with Board() as board:
        with Leds() as leds:
            print('ブォーンブォーンと点滅 breathe500')
            leds.pattern = Pattern.breathe(800)
            leds.update(Leds.rgb_pattern(Color.RED))
    
            while True:
                board.button.wait_for_press()
                print('pressed!')
                board.led.state = Led.ON
                leds.update(Leds.rgb_on(Color.BLUE))

                pygame.mixer.music.load("/home/pi/dotfiles/specific/voicekit/app/sound.mp3")
                pygame.mixer.music.play(1)

                board.button.wait_for_release()
                print('released!')
                board.led.state = Led.OFF

                continue

if __name__ == '__main__':
    main()

