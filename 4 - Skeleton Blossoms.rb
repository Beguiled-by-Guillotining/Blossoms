eval_file SSO_RB_PATH()

len = 9

#instrument, amp, note_offset, pan
instr = [['Xylophone', 1.0, -6, -0.5],
         ['Xylophone', 1.0, -6, 0.5],
         ['Xylophone', 1.0, 0, -0.3],
         ['Xylophone', 1.0, 0, 0.3],
         ['Xylophone', 1.0, 6, -0.1],
         ['Xylophone', 1.0, 6, 0.1]]

curScale = scale :E3, :segah, num_octaves: 2

melodies = []
instr.each do |inst|
  loadName inst[0]
  melody = []
  len.times do
    melody.append([:r,:r,:r,:r, (choose curScale)].choose)
  end
  melodies.append(melody.ring)
end

live_loop :main do
  new_melodies = []
  instr.zip(melodies).each do |inst,melody|
    idx = tick % melody.length
    if one_in(9)
      melody = melody[0..idx] +
        [[:r, (choose curScale)].choose] +
        melody[(idx+1)..melody.length]
    end
    pl melody.look+inst[2], 1.0, inst[0], inst[1], 0, inst[3]
    new_melodies.append(melody)
  end
  melodies = new_melodies
  sleep 0.2
end