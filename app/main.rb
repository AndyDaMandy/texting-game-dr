#tbh this would simply be easier to make as an html game....???

def main_menu_tick(args)
  if args.state.screen == 0
    args.outputs.labels << [640, 540, 'Welcome!', 5, 1]
  else
    args.outputs.labels << [640, 540, 'Testing!', 5, 1]
  end
end

def tick(args)
  args.state.screen ||= 0
  main_menu_tick(args)
  if args.inputs.mouse.click
    args.state.screen += 1
  end
  main_menu_tick(args)
  args.outputs.labels << [100, 100, "#{args.state.screen}", 5, 1]
  # args.outputs.labels << [640, 540, 'Ando!', 5, 1]
  # args.outputs.labels << [640, 500, 'Test', 5, 1]
  # args.outputs.labels << [640, 460, 'Jeff', 5, 1]


end
