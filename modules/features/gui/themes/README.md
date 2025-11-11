# Themes

### Purpose
* Themes with stylix are generally tricky to approach. Some applications you'll not want stylix to apply theming to. Maybe you only want that non stylix theming applied for a certain theme that has its own package for that specific application. 
* Because my configuration is dendritic and I handle themes through their own module per theme, I don't have a clean way to handle both the theme and every particular application being enabled and what to do with them. 
* My current solution is to make merge conditional configuration on the case an application is present in the configuration or not. `modules.nixos.rose-pine` is the current example of how this would be done.
