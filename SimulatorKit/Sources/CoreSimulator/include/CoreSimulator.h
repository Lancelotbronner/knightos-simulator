//
//  CoreSimulator.h
//  SimulatorKit
//
//  Created by Christophe Bronner on 2025-01-05.
//

#pragma once

#include <stdbool.h>
#include <stdint.h>

union Pair {
	uint16_t rawValue;
	struct {
		unsigned char high;
		unsigned char low;
	};
	unsigned char bytes[2];
};

union FlagsZ80 {
	unsigned char rawValue;
	struct {
		bool C : 1;
		bool N : 1;
		bool PV : 1;
		bool _3 : 1;
		bool H : 1;
		bool _5 : 1;
		bool Z : 1;
		bool S : 1;
	};
};

struct RegistersZ80 {
	union {
		uint16_t AF;
		struct {
			union {
				unsigned char F;
				struct {
					unsigned char C  : 1;
					unsigned char N  : 1;
					unsigned char PV : 1;
					unsigned char _3 : 1;
					unsigned char H  : 1;
					unsigned char _5 : 1;
					unsigned char Z  : 1;
					unsigned char S  : 1;
				} flags;
			};
			unsigned char A;
		};
	};
	union {
		uint16_t BC;
		struct {
			unsigned char C;
			unsigned char B;
		};
	};
	union {
		uint16_t DE;
		struct {
			unsigned char E;
			unsigned char D;
		};
	};
	union {
		uint16_t HL;
		struct {
			unsigned char L;
			unsigned char H;
		};
	};
	uint16_t _AF, _BC, _DE, _HL;
	uint16_t PC, SP;
	union {
		uint16_t IX;
		struct {
			unsigned char IXL;
			unsigned char IXH;
		};
	};
	union {
		uint16_t IY;
		struct {
			unsigned char IYL;
			unsigned char IYH;
		};
	};
	unsigned char I, R;
	uint16_t WZ;
};

struct StateZ80 {
	uint16_t prefix;
	uint8_t bus;
	union {
		struct {
			uint8_t : 2;
			uint8_t int_mode : 2;
		};
		struct {
			bool IFF1 : 1;
			bool IFF2 : 1;
			bool : 1;
			bool : 1;
			// Internal use:
			bool IFF_wait : 1;
			bool halted : 1;
			bool interrupt : 1;
		};
	};
};

struct InstructionZ80 {
	union {
		unsigned char rawValue;
		struct {
			unsigned char x : 2;
			unsigned char y : 3;
			unsigned char z : 3;
		};
		struct {
			unsigned char : 2;
			unsigned char p : 2;
		};
		struct {
			bool : 1;
			bool : 1;
			bool : 1;
			bool : 1;
			bool q : 1;
		};
	};
};
