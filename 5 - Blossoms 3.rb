eval_file SSO_RB_PATH()

len = 16
randomness = 42

use_random_seed 2

#instrument, amp, note_offset, pan
instr = [['Harp', 0.4, 0, -0.1],
         ['Xylophone', 0.05, 0, -0.1],
         ['Glockenspiel', 0.05, 0, 0.1],
         ['Flutes sus', 0.5, 0, -0.1],
         ['Violas sus', 0.15, 12, 0.3],
         ['Tuba sus', 1.0, -12, -0.1],
         ['Basses piz', 0.8, -24, 0.1],
         ['Cor Anglais', 1.0, 12, 0.1], #Some of its notes won't be played but I want to stay in key so that can't be helped
         ['2nd Violins sus', 0.4, 12, -0.2],
         ['Clarinets', 1.0, 0, 0.0]]

curScale = chord :C3, :minor7, num_octaves: 2

melodies = []
instr.each do |inst|
  loadName inst[0]
  melody = []
  len.times do
    melody.append(:r)
  end
  melodies.append(melody.ring)
end

live_loop :main do
  new_melodies = []
  instr.zip(melodies).each do |inst,melody|
    idx = tick % melody.length
    if one_in(randomness)
      melody = melody[0..idx] +
        [[:r, (choose curScale), (choose curScale)].choose] +
        melody[(idx+1)..melody.length]
    end
    pl melody.look, 2.0, inst[0], inst[1] * (rrand 0.6, 1.0), inst[2], inst[3]
    new_melodies.append(melody)
  end
  melodies = new_melodies
  sleep 0.4
end

live_loop :randomizer do
  randomness -= 1
  stop if randomness <= 16
  sleep 5
end