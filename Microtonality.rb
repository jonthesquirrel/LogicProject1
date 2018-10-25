use_bpm 120 * 4

set :a_original_root, :e3
set :a_root, get[:a_original_root]
set :a_interval, 3

set :a_pan_top, 0.9
set :a_pan_bottom, -0.9
set :a_attack, 0.1
set :a_release, 1

in_thread do
  loop do
    cue :beat
    sleep 1
  end
end

in_thread do
  loop do
    sync :beat
    note = (scale get[:a_root] + get[:a_interval], :minor_pentatonic, num_octaves: 3).drop_last(3).reflect.butlast.tick
    play note, pan: get[:a_pan_top], attack: get[:a_attack], release: get[:a_release]
  end
end

in_thread do
  loop do
    sync :beat
    note = (scale get[:a_root], :major_pentatonic, num_octaves: 3).drop_last(3).reflect.butlast.tick
    play note, pan: get[:a_pan_bottom], attack: get[:a_attack], release: get[:a_release]
  end
end

in_thread do
  loop do
    sync :beat
    set :a_root, get[:a_root] + 1.5 if beat % 24 == 0
    set :a_root, get[:a_original_root] if beat % (24 * 4) == 0
  end
end

in_thread do
  loop do
    sync :beat
    set :a_pan_top, (range 0.9, -0.9, step: 0.0375, inclusive: true).reflect.butlast.tick
    set :a_pan_bottom, (range -0.9, 0.9, step: 0.0375, inclusive: true).reflect.butlast.tick
  end
end

in_thread do
  loop do
    sync :beat
    set :a_release, (range 2.7, 0.3, step: 0.2, inclusive: true).reflect.butlast.tick
  end
end
