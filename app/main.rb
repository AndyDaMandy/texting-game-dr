def game(args)

end

def menu_up(args)
  if args.inputs.mouse.click&.inside_rect?(450, 410, 120, 50)
    args.state.screen += 1
  end
end


def main_menu_tick(args)
  if args.state.screen == 0
    args.outputs.labels << [640, 540, 'Welcome!', 5, 1]
    args.outputs.borders << [450, 410, 120, 50]
    args.outputs.labels << [500, 450, "Forward", 4, 1]
    args.outputs.borders << [100, 100, 1000, 80]

  else
    args.outputs.labels << [640, 540, 'Testing!', 5, 1]
  end
end

def tick(args)
  args.outputs.labels <<  [460, 400, "Borders (x, y, w, h, r, g, b, a)"]
  args.state.screen ||= 0
  main_menu_tick(args)
  menu_up(args)
  args.outputs.labels << [100, 100, "#{args.state.screen}", 5, 1]
  # args.outputs.labels << [640, 540, 'Ando!', 5, 1]
  # args.outputs.labels << [640, 500, 'Test', 5, 1]
  # args.outputs.labels << [640, 460, 'Jeff', 5, 1]


end
