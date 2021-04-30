eval_file SSO_RB_PATH()

len = 16
randomness = 30
pauses = 20

#instrument, amp, note_offset, pan
instr = allVoices()


define :liveLoop do |inst|
  melody = []
  len.times do
    melody.append([:r, 1.0])
  end
  
  pan = rrand -0.5, 0.5
  
  live_loop ("main" + inst[0]).to_sym do
    idx = tick % len
    if one_in(randomness)
      melody = melody[0..idx] +
        [[(knit :r, pauses, (rrand inst[4], inst[5]), 1).choose,
          (rrand 0.6, 1.0)
          ]] +
        melody[(idx+1)..melody.length]
    end
    pl melody[idx][0], 1.2, inst[0], melody.look[1], 0, pan
    
    
    pan = rrand -0.5, 0.5 if one_in 100
    
    sleep 0.2
  end
end

instr.each do |inst|
  liveLoop inst
end

live_loop :unpauser do
  pauses -= 1
  stop if pauses <= 2
  sleep 10.0
end


