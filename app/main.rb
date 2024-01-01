def init_args(args)
  args.state.screen ||= 0
  args.state.character_name |= "Blank"
end

def game(args)
  case args.state.screen
  when 1
    args.outputs.labels << [640, 540, 'Testing, does this work?!', 5, 1]
    # we could create buttons here... this will allow us to pick where we go
    # We set buttons here as well.
    button_creator("Forward", 2, 2, args)
    button_creator("Backward", 0, 1, args)
  else
    args.outputs.labels << [640, 540, 'Testing!', 5, 1]
    button_creator("Forward", 2, 2, args)
    button_creator("Backward", 0, 1, args)
  end
end

def game_state(args)
  case args.state.screen
  when 0
    main_menu(args)
  else
    game(args)
  end
end

def main_menu(args)
  args.outputs.labels << [640, 540, 'Texting Game', 5, 1]
  args.outputs.borders << [450, 410, 120, 50]
  args.outputs.labels << [500, 450, "Forward", 4, 1]
  args.outputs.borders << [100, 100, 1000, 80]
  button_creator("Start Game", 1, 2, args)
end

def button_creator(text, state, position, args)
  case position
  when 0
    x = 10
    y = 10
  when 1
    x = 80
    y = 80
  when 2
    x = 150
    y = 150
  else
    # type code here
    x = 100
    y = 100
  end
  label = {
    x:                       x,
    y:                       y,
    text:                    text,
    size_enum:               2,
    alignment_enum:          1, # 0 = left, 1 = center, 2 = right
    r:                       155,
    g:                       50,
    b:                       50,
    a:                       255,
    # font:                    "fonts/manaspc.ttf",
    vertical_alignment_enum: 0  # 0 = bottom, 1 = center, 2 = top
  }
  border = {
    x: x,
    y: y,
    w: 100,
    h: 50,
    r: 255,
    g: 255,
    b: 255,
    a: 255,
    vertical_alignment_enum: 0
  }
  args.outputs.labels << label
  args.outputs.borders << border

  if (args.inputs.mouse.click) &&
     (args.inputs.mouse.point.inside_rect? border)
    args.gtk.notify! "button was clicked"
    args.state.screen = state
  end

end

def menu_up(args)
  args.state.click_me_button.border ||= { x: 10, y: 10, w: 100, h: 50 }
  args.state.click_me_button.label  ||= { x: 10, y: 10, text: "Forward" }

  # render the button
  args.outputs.borders << args.state.click_me_button.border
  args.outputs.labels << args.state.click_me_button.label

  # determine if the button has been clicked
  if (args.inputs.mouse.click) && 
     (args.inputs.mouse.point.inside_rect? args.state.click_me_button.border)
    args.gtk.notify! "button was clicked"
    args.state.screen += 1
  end
  game_state(args)
end

def menu_down(args)
  args.state.down_button.border ||= { x: 100, y: 100, w: 100, h: 50 }
  args.state.down_button.label  ||= { x: 100, y: 100, text: "Backward" }

  # render the button
  args.outputs.borders << args.state.down_button.border
  args.outputs.labels << args.state.down_button.label

  # determine if the button has been clicked
  if (args.inputs.mouse.click) && 
     (args.inputs.mouse.point.inside_rect? args.state.down_button.border)
    args.gtk.notify! "button was clicked"
    args.state.screen -= 1
  end
  game_state(args)
end

def tick(args)
  init_args(args)
  game_state(args)
  # menu_up(args)
  # menu_down(args)
  args.outputs.labels << [100, 100, "#{args.state.screen}", 5, 1]


end
