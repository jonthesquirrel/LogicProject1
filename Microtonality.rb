use_bpm 120 * 4
set :original_root, :e3
set :root, get[:original_root]
set :interval, 3

set :pan_top, 0.9
set :pan_bottom, -0.9
set :attack, 0
set :attack_level, 1
set :decay, 0
set :decay_level, 1
set :sustain, 0
set :sustain_level, 1
set :release, 1

in_thread do
  loop do
    cue :beat
    sleep 1
  end
end

in_thread do
  loop do
    sync :beat
    note = (scale get[:root] + get[:interval], :minor_pentatonic, num_octaves: 3).drop_last(3).reflect.butlast.tick
    play note, pan: get[:pan_top], attack: get[:attack], attack_level: get[:attack_level], decay: get[:decay], decay_level: get[:decay_level], sustain: get[:sustain], sustain_level: get[:sustain_level], release: get[:release]
  end
end

in_thread do
  loop do
    sync :beat
    note = (scale get[:root], :major_pentatonic, num_octaves: 3).drop_last(3).reflect.butlast.tick
    play note, pan: get[:pan_bottom], attack: get[:attack], attack_level: get[:attack_level], decay: get[:decay], decay_level: get[:decay_level], sustain: get[:sustain], sustain_level: get[:sustain_level], release: get[:release]
  end
end

in_thread do
  loop do
    sync :beat
    set :root, get[:root] + 1.5 if beat % 24 == 0
    set :root, get[:original_root] if beat % (24 * 4) == 0
  end
end

in_thread do
  loop do
    sync :beat
    set :pan_top, (range 0.9, -0.9, step: 0.0375, inclusive: true).reflect.butlast.tick
    set :pan_bottom, (range -0.9, 0.9, step: 0.0375, inclusive: true).reflect.butlast.tick
  end
end

in_thread do
  loop do
    sync :beat
    set :release, (range 3.44, 0.44, step: 0.25, inclusive: true).reflect.butlast.tick
  end
end