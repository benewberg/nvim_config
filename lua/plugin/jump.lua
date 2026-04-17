local jump = require('jump')
jump.setup({
    -- search = 'LeapLabelPrimary',
    -- label = 'LeapLabelSecondary',
    search = 'FlashCurrent',
})
vim.keymap.set({'n', 'x', 'o'}, 's', jump.start, {})
