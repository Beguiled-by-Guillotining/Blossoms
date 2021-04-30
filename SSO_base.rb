#program to utilise 48 different sample voices from Sonatina Symphonic Library
#orginally written by Robin Newman, March 2016

#path to library samples folder (including trailing /)
path = SSO_SAMPLES_DIR()

#create array of instrument details
voices=[['1st Violins piz','1st Violins','1st-violins-piz-rr1-',1,:g3,:b6],\
        ['1st Violins sus','1st Violins','1st-violins-sus-',1,:g3,:b6],\
        ['1st Violins stc','1st Violins','1st-violins-stc-rr1-',1,:g3,:b6],\
        ['2nd Violins piz','2nd Violins','2nd-violins-piz-rr1-',1,:g3,:b6],\
        ['2nd Violins sus','2nd Violins','2nd-violins-sus-',1,:g3,:b6],\
        ['2nd Violins stc','2nd Violins','2nd-violins-stc-rr1-',1,:g3,:b6],\
        ['Alto Flute','Alto Flute','alto_flute-',1,:g3,:g6],\
        ['Bass Clarinet','Bass Clarinet','bass_clarinet-',2,:d2,:d5],\
        ['Bass Trombone','Bass Trombone','bass_trombone-',1,:e1,:g4],\
        ['Basses piz','Basses','basses-piz-rr1-',0,:c1,:c4],\
        ['Basses sus','Basses','basses-sus-',0,:c1,:c4],\
        ['Basses stc','Basses','basses-stc-rr1-',0,:c1,:c4],\
        ['Bassoon','Bassoon','bassoon-',1,:as1,:d5],\
        ['Bassoons','Bassoons','bassoons-sus-',1,:as1,:d5],\
        ['Celli piz','Celli','celli-piz-rr1-',0,:a2,:bb5],\
        ['Celli sus','Celli','celli-sus-',0,:a2,:bb5],\
        ['Celli stc','Celli','celli-stc-rr1-',0,:a2,:c5],\
        ['Cello','Cello','cello-',0,:a2,:bb5],\
        ['Chorus female','Chorus','chorus-female-',3,:as4,:gs5],\
        ['Chorus male','Chorus','chorus-male-',3,:as2,:gs3],\
        ['Clarinet','Clarinet','clarinet-',2,:d3,:d6],\
        ['Clarinets','Clarinets','clarinets-sus-',2,:d3,:d6],\
        ['Contrabassoon','Contrabassoon','contrabassoon-',1,:as0,:as3],\
        ['Cor Anglais','Cor Anglais','cor_anglais-',2,:f3,:f5],\
        ['Flute','Flute','flute-',0,:b3,:a4],\
        ['Flutes sus','Flutes','flutes-sus-',0,:c3,:bb5],\
        ['Flutes stc','Flutes','flutes-stc-rr1-',0,:c3,:bb5],\
        ['Grand Piano p','Grand Piano','piano-p-',0,:b0,:cs8],\
        ['Grand Piano f','Grand Piano','piano-f-',0,:b0,:cs8],\
        ['Harp','Harp','harp-',0,:c2,:c7],\
        ['Horn','Horn','horn-',1,:e2,:e5],\
        ['Horns stc','Horns','horns-stc-rr1-',1,:e2,:e5],\
        ['Horns sus','Horns','horns-sus-',1,:e2,:e5],\
        ['Oboe','Oboe','oboe-',1,:as3,:c6],\
        ['Oboes','Oboes','oboes-sus-',1,:as3,:c6],\
        ['Xylophone','Percussion','xylophone-',1,:a2,:b5],\
        ['Piccolo','Piccolo','piccolo-',0,:b3,:g6],\
        ['Tenor Trombone','Tenor Trombone','tenor_trombone-',1,:ds2,:b4],\
        ['Trombones sus','Trombones','trombones-sus-',1,:ds2,:b4],\
        ['Trombones stc','Trombones','trombones-stc-rr1-',1,:ds2,:b4],\
        ['Trumpet','Trumpet','trumpet-',1,:e3,:f6],\
        ['Trumpets sus','Trumpets','trumpets-sus-',1,:e3,:f6],\
        ['Trumpets stc','Trumpets','trumpets-stc-rr1-',1,:e3,:f6],\
        ['Tuba sus','Tuba','tuba-sus-',1,:e1,:d4],\
        ['Tuba stc','Tuba','tuba-stc-rr1-',1,:e1,:d4],\
        ['Violas piz','Violas','violas-piz-rr1-',0,:c3,:c6],\
        ['Violas sus','Violas','violas-sus-',0,:c3,:c6],\
        ['Violin','Violin','violin-',1,:g3,:d7],\
        ['Timpani roll','Percussion','timpani-roll-',0,:c1,:c2],\
        ['Timpani roll cresc','Percussion','timpani-roll-crsc-',0,:c1,:c2],\
        ['Glockenspiel','Percussion','glockenspiel-',0,:c3,:c6],\
        ['Timpani f lh','Percussion','timpani-f-lh-',0,:c1,:c2],\
        ['Timpani f rh','Percussion','timpani-f-rh-',0,:c1,:c2],\
        ['Timpani p lh','Percussion','timpani-p-lh-',0,:c1,:c2],\
        ['Timpani p rh','Percussion','timpani-p-rh-',0,:c1,:c2]]

define :load do |i|
  load_samples path + voices[i][1], voices[i][2]
end

define :loadName do |name|
  load allVoices.index(allVoices.assoc name)
end

define :allVoices do
  return voices
end

define :SSOSamplePath do
  return path
end

define :printOverview do
  puts 'The following voices from Sonatina Symphonic Library can be used:-'
  voices.each_with_index do |n, i|
    puts i.to_s, n[0], n[4].to_s + " - 3  to " + n[5].to_s + " + 5"
  end
  puts voices.length.to_s + ' voices'
end

#setup global variables
sampledir = ''
sampleprefix = ''
offsetclass = ''
low = ''
high = ''
paths = ''

#setup data for current inst
define :setup do |inst, path|
  sampledir = voices.assoc(inst)[1]
  sampleprefix = voices.assoc(inst)[2]
  offsetclass = voices.assoc(inst)[3]
  low = voices.assoc(inst)[4]
  high = voices.assoc(inst)[5]
  
  #amend path for instrument sampledir
  paths = path + sampledir + '/'
end

#define routine to play sample
define :pl do |np, d, inst, amp=1.0, tp=0, pan=0, compressSlope=1, compressTime=0.01|
  
  if ([nil,:r,:rest].include? np) #don't play rests
    return
  end
  
  setup(inst,path)
  
  #check if note in range of supplied samples
  #use lowest/highest sample for out of range
  change=0 #used to give rpitch for coverage outside range
  frac=0
  n=np+tp #note allowing for transposition
  
  if n.is_a?(Numeric) #allow frac tp or np
    frac=n-n.to_i
    n=n.to_i
  end
  
  if note(np)+tp<note(low) #calc adjustment for low note
    change=note(np).to_i+tp-note(low)
    n=note(low)
  end
  if note(np).to_i+tp > note(high) #calc adjustment for high note
    change = note(np).to_i+tp-note(high)
    n=note(high)
  end
  
  if change < -3 or change > 5 #set allowable out of range
    #if outside print messsage
    puts 'inst: '+inst+' note '+np.to_s+' with transpostion '+tp.to_s+' out of sample range'
  else #otherwise calc and play it
    #calculate base note and octave
    base=note(n)%12
    oc = note(n) #do in 2 stages because of alignment bug
    oc=oc/12 -1
    
    #find first part of sample note
    slookup=['c','c#','d','d#','e','f','f#','g','g#','a','a#','b']
    #lookup sample to use,and rpitch offset, according to offsetclass
    case offsetclass
    when 0
      oc += 1 if base == 11 #adjust if sample needs next octave
      snumber=[0,0,3,3,3,6,6,6,9,9,9,0]
      offset=[ 0,1,-1,0,1,-1,0,1,-1,0,1,-1]
    when 1
      snumber=[1,1,1,4,4,4,7,7,7,10,10,10]
      offset=[-1,0,1,-1,0,1,-1,0,1,-1,0,1]
    when 2
      oc -= 1 if base == 0 #adjust if sample needs previous octave
      snumber=[11,2,2,2,5,5,5,8,8,8,11,11]
      offset=[1,-1,0,1,-1,0,1,-1,0,1,-1,0]
    when 3
      snumber=[0,1,2,3,4,5,6,7,8,9,10,11] #this class has sample for every note
      offset=[0,0,0,0,0,0,0,0,0,0,0,0]
    end
    
    #generate sample name
    sname = sampleprefix + (slookup[snumber[base]]).to_s + oc.to_s
    
    #play sample with appropriate rpitch value
    sample paths, sname,
      rpitch: offset[base] + change + frac,
      sustain: 0.9*d,
      release: d,
      pan: pan,
      amp: amp,
      compress: (compressSlope != 1),
      threshold: 0.1,
      slope_below: compressSlope,
      slope_above: compressSlope,
      clamp_time: compressTime,
      relax_time: compressTime
  end
end

#function to play lists of linked samples/durations
define :plarray do |notes, durations, inst, amp=1.0, tp=0, pan=0|
  notes.zip(durations).each do |n,d|
    pl(n, d, inst, amp, tp, pan)
    sleep d
  end
end