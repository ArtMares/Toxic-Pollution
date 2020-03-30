-- -- -- PATHS
-- This paths is meant for be used only in data stages
-----------------------------------------------------------------------------------------------------------------
-- -- GENERAL PATHS
-----------------------------------------------------------------------------------------------------------------
tp_path                     = ToxicPollution.ModPath()
tp_prototypes_path          = tp_path .. "prototypes/"
-----------------------------------------------------------------------------------------------------------------
-- Prototypes:
tp_damages_path             = tp_prototypes_path .. "damages/"
tp_entities_path            = tp_prototypes_path .. "entities/"
tp_technologies_path        = tp_prototypes_path .. "technologies/"
-----------------------------------------------------------------------------------------------------------------
-- -- GRAPHICS PATHS
-----------------------------------------------------------------------------------------------------------------
tp_graphics_mod_path        = tp_path .. "graphics/"
-----------------------------------------------------------------------------------------------------------------
-- Entities:
tp_entities_graphic_path    = tp_graphics_mod_path .. "entities/"