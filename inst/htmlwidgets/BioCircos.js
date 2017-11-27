HTMLWidgets.widget({

  name: 'BioCircos',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    function objToArray(objectLiteral) {
      var piece1 = Object.keys(objectLiteral);
      var piece2 = Object.values(objectLiteral);
      var result = [];
      for (var i = 0; i < piece1.length; i++) {
        result.push([piece1[i], piece2[i]])
      }
      return result;
    }


    return {

      renderValue: function(x) {

        opts = x // Rename variable

        el.innerText = opts.message; // Display input message
        
        d3.selectAll("p").style("color", "red"); // D3: paragraphs are now written in red

        var BioCircosGenome = objToArray(opts.genome);

        var maxRadius = Math.min(height, width)/2;

        BioCircos01 = new BioCircos(BioCircosGenome,{
           target : el.id,
           svgWidth : width,
           svgHeight : height,
           chrPad : 0.04,
           innerRadius: 0.7*maxRadius,
           outerRadius: 0.8*maxRadius,
           zoom : true,
           genomeFillColor: ["rgb(153,102,0)", "rgb(102,102,0)", "rgb(153,153,30)", "rgb(204,0,0)","rgb(255,0,0)", "rgb(255,0,204)", "rgb(255,204,204)", "rgb(255,153,0)", "rgb(255,204,0)", "rgb(255,255,0)", "rgb(204,255,0)", "rgb(0,255,0)","rgb(53,128,0)", "rgb(0,0,204)", "rgb(102,153,255)", "rgb(153,204,255)", "rgb(0,255,255)", "rgb(204,255,255)", "rgb(153,0,204)", "rgb(204,51,255)","rgb(204,153,255)", "rgb(102,102,102)", "rgb(153,153,153)", "rgb(204,204,204)"],
           CNVMouseOnDisplay : true,
           HEATMAPMouseOnDisplay : true,
           SNPMouseOnDisplay : true,
           FUSIONMouseOnDisplay: true,
           HISTOGRAMMouseOnDisplay: true,
           LINEMouseOnDisplay: true,
           genomeBorder : {
              display : true,
              borderColor : "#000",
              borderSize : 0.5
           },
           ticks : {
              display : true,
              len : 5,
              color : "#000",
              textSize : 10,
              textColor : "#000",
              scale : 30000000
           },
           genomeLabel : {
              display : true,
              textSize : 15,
              textColor : "#000",
              dx : 0.028,
              dy : "-0.55em"
           }
        });

        BioCircos01.draw_genome(BioCircos01.genomeLength);
      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});