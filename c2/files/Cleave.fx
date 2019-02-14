/////////////////////////////////////////////////////////
// Cleave effect
varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;

uniform lowp float pixelWidth;
uniform lowp float pixelHeight;
uniform lowp float Cleeve;
uniform lowp float CleeveCenter;
uniform lowp float Power;
uniform mediump vec2 pixelSize;
uniform mediump vec2 srcOriginStart;
uniform mediump vec2 srcOriginEnd;

void main(void)
{	
	mediump vec2 tex = vTex;
	mediump float deflection;
	mediump float texDef;
	
	deflection = (pixelHeight*Cleeve)*pow(vTex.x,Power);

	if (tex.y > CleeveCenter)
	{
		tex.y -= deflection;
		texDef = tex.y;
		tex.y = clamp(tex.y, CleeveCenter, 1.0);
	} else
	{
		tex.y += deflection;
		texDef = tex.y;
		tex.y = clamp(tex.y, 0.0, CleeveCenter);
	}

	tex = clamp(tex, 0.0, 1.0);

	mediump vec4 finalColor = texture2D(samplerFront,tex);

	if (tex.y != texDef) {
		finalColor.a = 0.0;
		finalColor.r = 0.0;
		finalColor.g = 0.0;
		finalColor.b = 0.0;
	}
		
	gl_FragColor = finalColor;
}

// Reference from C3 version of effect, more difficult due to C3 using spritesheets, new C3 uniforms help with that.
/*	mediump vec2 tex = vTex;
	mediump float deflection;
	mediump float texDef;
	
	// Calculate the normalised position n of vTex in the foreground rectangle and use that for Skend amount
	mediump vec2 n = (vTex - srcOriginStart) / (srcOriginEnd - srcOriginStart);
	deflection = (pixelSize.y*Cleeve)*pow(n.x,Power);

	if (n.y < CleeveCenter)
	{
		tex.y -= deflection;
		texDef = tex.y;
		tex.y = clamp(tex.y, srcOriginStart.y, srcOriginStart.y+(srcOriginEnd.y - srcOriginStart.y)*CleeveCenter);
	} else
	{
		tex.y += deflection;
		texDef = tex.y;
		tex.y = clamp(tex.y, srcOriginStart.y+(srcOriginEnd.y - srcOriginStart.y)*CleeveCenter, srcOriginEnd.y);
	}

	tex = clamp(tex, srcOriginStart, srcOriginEnd);

	mediump vec4 finalColor = texture2D(samplerFront,tex);

	if (tex.y != texDef) {
		finalColor.a = 0.0;
		finalColor.r = 0.0;
		finalColor.g = 0.0;
		finalColor.b = 0.0;
	}
		
	gl_FragColor = finalColor;
	*/