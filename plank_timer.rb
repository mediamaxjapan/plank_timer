# -*- encoding: utf-8 -*-
require 'find'

class Timer < Struct.new(:start_at)
  def self.start()
    Timer.new(Time.now())
  end

  def sleep_until(count)
    now = Time.now()
    sleep_sec = count - (now - start_at)
    if (sleep_sec <= 0.0)
      return
    end

    sleep(sleep_sec)
  end
end

def sec_of(set, sec_of_set)
  (set - 1) * 60 + sec_of_set
end

SPEECH_TIMINGS = {
  sec_of(1,  5) => '15秒',
  sec_of(1, 10) => '10秒',
  sec_of(1, 15) => '5',
  sec_of(1, 16) => '4',
  sec_of(1, 17) => '3',
  sec_of(1, 18) => '2',
  sec_of(1, 19) => '1',
  sec_of(1, 20) => 'ハーフプランクスタート',
  sec_of(1, 25) => '15秒',
  sec_of(1, 30) => '10秒',
  sec_of(1, 35) => '5',
  sec_of(1, 36) => '4',
  sec_of(1, 37) => '3',
  sec_of(1, 38) => '2',
  sec_of(1, 39) => '1',
  sec_of(1, 40) => '休憩です',

  sec_of(2, -5) => '5',
  sec_of(2, -4) => '4',
  sec_of(2, -3) => '3',
  sec_of(2, -2) => '2',
  sec_of(2, -1) => '1',
  sec_of(2,  0) => 'ハーフプランクスタート',
  sec_of(2,  5) => '15秒',
  sec_of(2, 10) => '10秒',
  sec_of(2, 15) => '5',
  sec_of(2, 16) => '4',
  sec_of(2, 17) => '3',
  sec_of(2, 18) => '2',
  sec_of(2, 19) => '1',
  sec_of(2, 20) => 'そのまま左足を上げます',
  sec_of(2, 25) => '15秒',
  sec_of(2, 30) => '10秒',
  sec_of(2, 35) => '5',
  sec_of(2, 36) => '4',
  sec_of(2, 37) => '3',
  sec_of(2, 38) => '2',
  sec_of(2, 39) => '1',
  sec_of(2, 40) => '休憩です',

  sec_of(3, -5) => '5',
  sec_of(3, -4) => '4',
  sec_of(3, -3) => '3',
  sec_of(3, -2) => '2',
  sec_of(3, -1) => '1',
  sec_of(3,  0) => 'ハーフプランクスタート',
  sec_of(3,  5) => '15秒',
  sec_of(3, 10) => '10秒',
  sec_of(3, 15) => '5',
  sec_of(3, 16) => '4',
  sec_of(3, 17) => '3',
  sec_of(3, 18) => '2',
  sec_of(3, 19) => '1',
  sec_of(3, 20) => 'そのまま右足を上げます',
  sec_of(3, 25) => '15秒',
  sec_of(3, 30) => '10秒',
  sec_of(3, 35) => '5',
  sec_of(3, 36) => '4',
  sec_of(3, 37) => '3',
  sec_of(3, 38) => '2',
  sec_of(3, 39) => '1',
  sec_of(3, 40) => '休憩です',

  sec_of(4, -5) => '5',
  sec_of(4, -4) => '4',
  sec_of(4, -3) => '3',
  sec_of(4, -2) => '2',
  sec_of(4, -1) => '1',
  sec_of(4,  0) => 'ハーフプランクスタート',
  sec_of(4,  5) => '15秒',
  sec_of(4, 10) => '10秒',
  sec_of(4, 15) => '5',
  sec_of(4, 16) => '4',
  sec_of(4, 17) => '3',
  sec_of(4, 18) => '2',
  sec_of(4, 19) => '1',
  sec_of(4, 20) => 'レフトサイドプランクスタート',
  sec_of(4, 25) => '15秒',
  sec_of(4, 30) => '10秒',
  sec_of(4, 35) => '5',
  sec_of(4, 36) => '4',
  sec_of(4, 37) => '3',
  sec_of(4, 38) => '2',
  sec_of(4, 39) => '1',
  sec_of(4, 40) => '休憩です',

  sec_of(5, -5) => '5',
  sec_of(5, -4) => '4',
  sec_of(5, -3) => '3',
  sec_of(5, -2) => '2',
  sec_of(5, -1) => '1',
  sec_of(5,  0) => 'ハーフプランクスタート',
  sec_of(5,  5) => '15秒',
  sec_of(5, 10) => '10秒',
  sec_of(5, 15) => '5',
  sec_of(5, 16) => '4',
  sec_of(5, 17) => '3',
  sec_of(5, 18) => '2',
  sec_of(5, 19) => '1',
  sec_of(5, 20) => 'ライトサイドプランクスタート',
  sec_of(5, 25) => '15秒',
  sec_of(5, 30) => '10秒',
  sec_of(5, 35) => '5',
  sec_of(5, 36) => '4',
  sec_of(5, 37) => '3',
  sec_of(5, 38) => '2',
  sec_of(5, 39) => '1',
  sec_of(5, 40) => '休憩です',

  sec_of(6, -5) => '5',
  sec_of(6, -4) => '4',
  sec_of(6, -3) => '3',
  sec_of(6, -2) => '2',
  sec_of(6, -1) => '1',
  sec_of(6,  0) => 'リバースハーフプランクスタート',
  sec_of(6,  5) => '15秒',
  sec_of(6, 10) => '10秒',
  sec_of(6, 15) => '5',
  sec_of(6, 16) => '4',
  sec_of(6, 17) => '3',
  sec_of(6, 18) => '2',
  sec_of(6, 19) => '1',
  sec_of(6, 20) => 'リバースフルプランクスタート',
  sec_of(6, 25) => '15秒',
  sec_of(6, 30) => '10秒',
  sec_of(6, 35) => '5',
  sec_of(6, 36) => '4',
  sec_of(6, 37) => '3',
  sec_of(6, 38) => '2',
  sec_of(6, 39) => '1',
  sec_of(6, 40) => 'トレーニング終了です。お疲れ様でした。',
}

REG_AUDIO_EXT = %r!\.(mp3|wav)$!
def load_yells
  out = []
  Find.find("yell") do |file|
    out.push(file) if REG_AUDIO_EXT =~ file
  end
  out
end

def main
  yells = load_yells

  say1('プランクトレーニングをはじめます')
  sleep(10)

  pre_timer = Timer.start
  say('5')
  pre_timer.sleep_until(1)
  say('4')
  pre_timer.sleep_until(2)
  say('3')
  pre_timer.sleep_until(3)
  say('2')
  pre_timer.sleep_until(4)
  say('1')
  pre_timer.sleep_until(5)

  last_yelled_at = nil
  timer = Timer.start
  say1('フルプランク スタート')
  whoSay = 0
  (1..345).each {|i|
    timer.sleep_until(i)
    speech = SPEECH_TIMINGS[i]
    if (speech)
      if whoSay % 2 == 0 then say(speech)
      else say1(speech) end
      whoSay += 1 
    end

    if yells.size > 0 && (!last_yelled_at || last_yelled_at < i - 2) && rand(2) == 0
      yell(yells.shuffle.first)
      last_yelled_at = i
    end
  }
end

def say(word)
  Thread.new {
    puts(word)
    system('say', '-v', 'kyoko', word)
  }.run
end

def say1(word)
  Thread.new {
    puts(word)
    system('say', '-v', 'otoya', word)
  }.run
end

def yell(file)
  if File.exists?(file)
    Thread.new {
      system('afplay', '-v', '0.5', file)
    }.run
  end
end

case $PROGRAM_NAME
when __FILE__
  main
when /spec[^\/]*$/
  # {spec of the implementation}
end

