eval_file SSO_RB_PATH()

len = 6
randomness = 16

#instrument, amp, note_offset, pan
instr = allVoices()


define :liveLoop do |inst|
  melody = []
  len.times do
    melody.append([:r, 1.0])
  end
  
  lowNote = (inst[4].to_i / 12) * 12 + 12
  octaves = (inst[5] - lowNote) / 12
  octaves = 1 if octaves < 1
  
  curScale = chord lowNote, :major7, num_octaves: octaves
  
  live_loop ("main" + inst[0]).to_sym do
    idx = tick % len
    if one_in(randomness)
      melody = melody[0..idx] +
        [[[:r, :r, :r, :r, (choose curScale)].choose,
          (rrand 0.6, 1.0)
          ]] +
        melody[(idx+1)..melody.length]
    end
    pl melody[idx][0], 1.2, inst[0], melody.look[1]
    
    sleep 0.2
    sleep 0.2 * len * (rrand_i 10, 30) if one_in 500
  end
end

instr.each do |inst|
  liveLoop inst
end


