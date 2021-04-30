eval_file SSO_RB_PATH()

len = 6
randomness = 100
loudInst = -1

#instrument, amp, note_offset, pan
instr = allVoices()


define :liveLoop do |inst, i|
  melody = []
  len.times do
    melody.append([:r, 1.0])
  end
  
  ampMult = 1.0
  ampMult = 0.3 if inst[0] == 'Xylophone'
  ampMult = 0.5 if inst[0] == 'Glockenspiel'
  
  pan = (rrand -0.9, 0.9)
  
  lowNote = (inst[4].to_i / 12) * 12 + 12
  octaves = (inst[5] - lowNote) / 12
  octaves = 1 if octaves < 1
  
  curScale = chord lowNote, :minor7, num_octaves: octaves
  
  live_loop ("main" + inst[0]).to_sym do
    idx = tick % len
    if one_in(randomness)
      melody = melody[0..idx] +
        [[[:r, :r, :r, :r, (choose curScale)].choose,
          (rrand 0.6, 1.0)
          ]] +
        melody[(idx+1)..melody.length]
    end
    
    soloMult = 1.0
    soloMult = 3.0 if loudInst == i
    pl melody[idx][0], 1.2, inst[0], melody.look[1] * ampMult * soloMult, 0, (loudInst == i ? 0.0 : pan)
    
    sleep 0.2
  end
end

i = 0
instr.each do |inst|
  liveLoop inst, i
  i += 1
end

live_loop :randomerer do
  randomness -= 1
  stop if randomness <= 3
  sleep 2.5
  loudInst = (rrand_i 0, instr.size() - 1)
end
live_loop :soloer do
  sleep (rrand 9.0, 14.0)
  loudInst = (rrand_i 0, instr.size() - 1)
end


