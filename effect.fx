/////////////////////////////////////////////////////////
// Cleeve effect
varying mediump vec2 vTex;
uniform lowp sampler2D samplerFront;

uniform lowp float pixelWidth;
uniform lowp float pixelHeight;
uniform lowp float Cleeve;
uniform lowp float CleeveCenter;
uniform lowp float Power;
uniform mediump vec2 pixelSize;
uniform mediump vec2 srcEnd;
uniform mediump vec2 srcStart;
uniform mediump vec2 srcOriginStart;
uniform mediump vec2 srcOriginEnd;
uniform mediump vec2 layoutStart;
uniform mediump vec2 layoutEnd;

void main(void)
{	
	mediump vec2 tex = vTex;
	mediump vec2 texOffset = tex - srcStart;
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
}