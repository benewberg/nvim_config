local jump = require('jump')
jump.setup({
    -- search = 'LeapLabelPrimary',
    -- label = 'LeapLabelSecondary',
    search = 'FlashCurrent',
})
vim.keymap.set({'n', 'x', 'o'}, 's', jump.start, {})

-- how-to's:
-- 1. since there is no `S` (backwards) mapping, continue to use `s` for jumping backwards;
-- it will print the labels both in a forward and backwards direction unlike leap.
-- 
-- 2. use nvim-surround to surround a jump destination with something, like single-quotes:
--     a. from the start of the first word: `yss`  -- tip: give a slight pause after the first `s`
--     b. start typing the jump destination chars
--     c. choose the label you want to jump to
--     d. type the surround you want
--
-- 3. delete or change up to a jump destination (previously used `z` for this with leap):
--     a. `v` to enter visual mode
--     b. `s` to trigger jump
--     c. start typing the jump destination chars
--     d. choose the label you want to jump to
--     e. `d` to delete the selection, or `c` to change the selection
