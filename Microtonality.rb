use_bpm 120 * 4
set :root, :d3
set :interval, 3

in_thread do
  loop do
    cue :beat
    sleep 1
  end
end

in_thread do
  loop do
    sync :beat
    play (scale get[:root], :major_pentatonic, num_octaves: 3).drop_last(3).reflect.drop_last(1).tick
    play (scale get[:root] + get[:interval], :minor_pentatonic, num_octaves: 3).drop_last(3).reflect.drop_last(1).tick
    set :root, get[:root] + 1.5 if beat % 24 == 0
  end
end
