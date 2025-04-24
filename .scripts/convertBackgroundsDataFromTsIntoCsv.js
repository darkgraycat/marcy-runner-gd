const input = [
    { 
        name: "Sunset Pine",
        skyTint: 0xcf573c,
        blocksTint: 0xcf573c,
        backgrounds: [
            [1, .20, 0xa53030, 0.1],
            [1, .25, 0x752438, 0.2],
            [2, .30, 0x402751, 0.3],
            [5, .40, 0x1e1d39, 0.4],
            [5, .45, 0x241527, 0.5],
        ],
        blocks: [0, 1],
    },
    { 
        name: "City Park",
        skyTint: 0x20a7f3,
        blocksTint: 0xf0b090,
        backgrounds: [
            [3, .30, 0x32899f, 0.1],
            [3, .35, 0x186267, 0.2],
            [8, .45, 0x164630, 0.3],
            [10, .50, 0x10381e, 0.4],
            [0, .70, 0x2671ab, 0.5],
        ],
        blocks: [0, 1],
    },
    { 
        name: "Old City Evening",
        skyTint: 0xf08050,
        blocksTint: 0x6b4d2e,
        backgrounds: [
            [3, .25, 0x823f16, 0.2],
            [4, .30, 0x55361b, 0.3],
            [2, .40, 0x2f301f, 0.4],
            [5, .45, 0x27291d, 0.45],
            [2, .50, 0x222419, 0.5],
        ],
        blocks: [0, 1],
    },
    { 
        name: "Morning",
        skyTint: 0xe48485,
        blocksTint: 0x8a7897,
        backgrounds: [
            [7, .20, 0xc2747d, 0.1],
            [3, .25, 0x8f6072, 0.2],
            [3, .30, 0x654e5c, 0.3],
            [9, .40, 0x453a4c, 0.4],
            [2, .50, 0x363040, 0.5],
        ],
        blocks: [0, 1],
    },
    { 
        name: "Bridge",
        skyTint: 0xffbda3,
        blocksTint: 0x816f9b,
        backgrounds: [
            [2, .20, 0xec8c9d, 0.1],
            [6, .25, 0xcc6a8d, 0.2],
            [8, .35, 0x8f496a, 0.3],
            [10, .40, 0x4f445d, 0.4],
            [9, .45, 0x35313f, 0.5],
        ],
        blocks: [0, 1],
    },
    { 
        name: "Depression",
        skyTint: 0x9dc1d0,
        blocksTint: 0xda8678,
        backgrounds: [
            [7, .25, 0x81b0c0, 0.1],
            [3, .30, 0x5a869b, 0.2],
            [7, .35, 0x4c697f, 0.3],
            [3, .40, 0x2f3e4d, 0.4],
            [3, .45, 0x202d3b, 0.5],
        ],
        blocks: [0, 1],
    },
    { 
        name: "Neon",
        skyTint: 0x123a78,
        blocksTint: 0x2e242e,
        backgrounds: [
            [1, .25, 0x513b72, 0.1],
            [7, .30, 0x763b6f, 0.2],
            [3, .35, 0x5f3043, 0.3],
            [3, .40, 0x43283c, 0.4],
            [3, .45, 0x221d25, 0.5],
        ],
        blocks: [0, 1],
    },
    { 
        name: "Forest",
        skyTint: 0xfec699,
        blocksTint: 0xd09a95,
        backgrounds: [
            [6, .25, 0xfeae84, 0.1],
            [2, .30, 0xf89d82, 0.2],
            [5, .40, 0xf18b80, 0.3],
            [2, .40, 0xce7d84, 0.4],
            [5, .50, 0xa7707c, 0.5],
        ],
        blocks: [0, 1],
    },
]


const START_IDX = 1;
const DELIMETER = '\t';
const RESOURCE_FILENAME_FORMAT = "res://data/background/bg_config_%d.tres";

const convertItem = (item, resourceIndex = 0) => {
    const { name, skyTint, backgrounds } = item;
    const cells = [];

    cells.push(RESOURCE_FILENAME_FORMAT.replace('%d', resourceIndex));  // resource_path
    cells.push(name); // resource_name
    cells.push(convertColor(skyTint)) //sky_color
    cells.push("ffffff") // sun_color (no value in old data, will setup manually)

    const backgroundCells = {
        colors: [],
        frames: [],
        offsets: [],
    }
    backgrounds.forEach(background => {
        const [frame, offset, color] = background;
        backgroundCells.colors.push(color.toString(16));
        backgroundCells.frames.push(frame);
        backgroundCells.offsets.push(offset);
    });
    // console.log(resourceIndex, backgroundCells);
    cells.push(...backgroundCells.colors); // row%d_color
    cells.push(0) // sun_frame
    cells.push(...backgroundCells.frames); // row%d_frame
    cells.push(0.20) // sun_offset
    cells.push(...backgroundCells.offsets); // row%d_offset

    return cells;
}

const convertColor = (oldColor = 0x0) => {
    return oldColor.toString(16);
}

const table = input.map((item, idx) => convertItem(item, idx + START_IDX));
const csv = table.map(item => item.join(DELIMETER)).join('\n');

console.table(csv);
