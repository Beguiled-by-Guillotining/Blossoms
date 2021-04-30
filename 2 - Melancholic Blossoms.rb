eval_file SSO_RB_PATH()

len = 9

#instrument, amp, note_offset
instr = [['Harp', 1.0, 0],
         ['Violas piz', 1.0, 0],
         ['Trumpets stc', 0.3, 0],
         ['Flutes sus', 0.5, 0]]

curScale = scale :C3, :minor, num_octaves: 2

melodies = []
instr.each do |inst|
  loadName inst[0]
  melody = []
  len.times do
    melody.append([:r, (choose curScale), (choose curScale)].choose)
  end
  melodies.append(melody.ring)
end

pauses = 1

live_loop :main do
  new_melodies = []
  idx = tick % melodies[0].length
  instr.zip(melodies).each do |inst,melody|
    if one_in(9)
      melody = melody[0..idx] +
        [(knit :r,pauses, (choose curScale),1).choose] +
        melody[(idx+1)..melody.length]
    end
    pl melody.look+inst[2], 1.0, inst[0], inst[1]
    new_melodies.append(melody)
  end
  melodies = new_melodies
  pauses += 1 if factor? look, 90
  sleep 0.2
end