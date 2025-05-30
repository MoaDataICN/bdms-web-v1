<!-- Chart External Plugins & custom -->

const dashBoardDoughnutLabel = {
    id: 'dashBoardDoughnutLabel',
    beforeDatasetsDraw(chart, args, pluginOptions) {
        const { ctx, chartArea, width, height, data } = chart;
        const meta = chart.getDatasetMeta(0);
        if (!meta || !meta.data || meta.data.length === 0) return;

        ctx.save();

        const xCoor = meta.data[0].x;
        const yCoor = meta.data[0].y;

        // 도넛 차트 크기에 따라 폰트 크기 조절
        const baseFontSize = Math.min(chartArea.width, chartArea.height);
        const mainFontSize = Math.round(baseFontSize / 6);  // 숫자 크기
        const subFontSize = Math.round(baseFontSize / 18);  // 라벨 크기

        ctx.font = `bold ${mainFontSize}px sans-serif`;
        ctx.fillStyle = 'rgba(79, 80, 82, 1)';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(summation(data.datasets[0].data), xCoor, yCoor - subFontSize * 2);

        ctx.font = `bold ${subFontSize}px sans-serif`;
        ctx.fillStyle = 'rgba(135, 138, 142, 1)';
        ctx.fillText("Today's Total Status", xCoor, yCoor + subFontSize * 2);

        ctx.restore();
    }
};

const userDtlDoughnutLabel = {
    id: 'userDtlDoughnutLabel',
    beforeDatasetsDraw(chart, args, pluginOptions) {
        const {ctx, chartArea, data} = chart;
        const centerX = (chartArea.left + chartArea.right) / 2;
        const centerY = (chartArea.top + chartArea.bottom) / 2;

        // 도넛 차트 크기에 따라 폰트 크기 조절
        const baseFontSize = Math.min(chartArea.width, chartArea.height);
        const totalFontSize = Math.round(baseFontSize / 6);  // 숫자 크기
        const labelFontSize = Math.round(baseFontSize / 18);  // 라벨 크기

        ctx.save();

        // 총합 숫자
        ctx.font = `bold ${totalFontSize}px sans-serif`;
        ctx.fillStyle = 'rgba(79, 80, 82, 1)';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(summation(data.datasets[0].data), centerX, centerY - totalFontSize / 3);

        let labelText = userDtlPeriod == 'all'
            ? "All"
            : "Last 24H";

        // 하단 라벨
        ctx.font = `bold ${labelFontSize}px sans-serif`;
        ctx.fillStyle = 'rgba(135, 138, 142, 1)';
        ctx.fillText(labelText, centerX, centerY + totalFontSize / 2.8);

        ctx.restore();
    }
};

const shadowCirclePlugin = {
    id: 'shadowCirclePlugin',
    beforeDatasetsDraw(chart, args, pluginOptions) {
        const { ctx, chartArea } = chart;

        const meta = chart.getDatasetMeta(0);
        const firstArc = meta.data[0];
        if (!firstArc) return;

        const centerX = (chartArea.left + chartArea.right) / 2;
        const centerY = (chartArea.top + chartArea.bottom) / 2;

        const outerRadius = firstArc.outerRadius;
        const innerRadius = firstArc.innerRadius;

        ctx.save();

        ctx.shadowColor = pluginOptions.shadowColor || 'rgba(0, 0, 0, 0.3)';
        ctx.shadowBlur = pluginOptions.shadowBlur || 20;
        ctx.shadowOffsetX = pluginOptions.shadowOffsetX || 5;
        ctx.shadowOffsetY = pluginOptions.shadowOffsetY || 5;

        ctx.beginPath();
        ctx.arc(centerX, centerY, outerRadius, 0, Math.PI * 2);
        ctx.arc(centerX, centerY, innerRadius, 0, Math.PI * 2, true);
        ctx.closePath();

        ctx.fillStyle = pluginOptions.shadowFill || '#fff';
        ctx.fill();

        ctx.restore();
    }
};


const getOrCreateTooltip = (chart) => {
    //let tooltipEl = chart.canvas.parentNode.querySelector('div');
    let tooltipEl = chart.canvas.parentNode.querySelector('div.tooltip');

    if (!tooltipEl) {
        tooltipEl = document.createElement('div');
        tooltipEl.classList.add('tooltip');
        tooltipEl.style.background = 'rgba(255,255,255,1)';
        tooltipEl.style.borderRadius = '3px';
        tooltipEl.style.color = 'rgba(109, 110, 111, 1)';
        tooltipEl.style.opacity = 1;
        tooltipEl.style.pointerEvents = 'none';
        tooltipEl.style.position = 'absolute';
        tooltipEl.style.width = '100px'
        tooltipEl.style.transform = 'translate(-50%, 0)';
        tooltipEl.style.transition = 'all .5s ease';

        const table = document.createElement('table');
        table.style.margin = '0px';

        tooltipEl.appendChild(table);
        chart.canvas.parentNode.appendChild(tooltipEl);
    }

    return tooltipEl;
};

const externalTooltipHandler = (context) => {
    // Tooltip Element
    const {chart, tooltip} = context;
    const tooltipEl = getOrCreateTooltip(chart);

    // Hide if no tooltip
    if (tooltip.opacity === 0) {
        tooltipEl.style.opacity = 0;
        return;
    }

    // Set Text
    if (tooltip.body) {
        const titleLines = tooltip.title || [];
        const bodyLines = tooltip.body.map(b => b.lines);

        const tableHead = document.createElement('thead');

        titleLines.forEach(title => {
            const tr = document.createElement('tr');
            tr.style.borderWidth = 0;

            const th = document.createElement('th');
            th.style.borderWidth = 0;
            const text = document.createTextNode(title);

            th.appendChild(text);
            tr.appendChild(th);
            tableHead.appendChild(tr);
        });

        const tableBody = document.createElement('tbody');
        bodyLines.forEach((body, i) => {
            const colors = tooltip.labelColors[i];

            const span = document.createElement('span');
            span.style.background = colors.backgroundColor;
            span.style.borderColor = colors.borderColor;
            span.style.borderWidth = '2px';
            span.style.marginRight = '10px';
            span.style.height = '10px';
            span.style.width = '10px';
            span.style.display = 'inline-block';

            const tr = document.createElement('tr');
            tr.style.backgroundColor = 'inherit';
            tr.style.borderWidth = 0;

            const td = document.createElement('td');
            td.style.borderWidth = 0;

            const text = document.createTextNode(body);

            td.appendChild(span);
            td.appendChild(text);
            tr.appendChild(td);
            tableHead.appendChild(tr);
        });

        const tableRoot = tooltipEl.querySelector('table');

        if (!tableRoot) {
            console.warn("❌ Tooltip table not found");
            return;
        }

        while (tableRoot.firstChild) {
            tableRoot.firstChild.remove();
        }

        tableRoot.appendChild(tableHead);
        tableRoot.appendChild(tableBody);
    }

    const {offsetLeft: positionX, offsetTop: positionY} = chart.canvas;

    tooltipEl.style.opacity = 1;
    tooltipEl.style.left = positionX + tooltip.caretX + 'px';
    tooltipEl.style.top = positionY + tooltip.caretY + 'px';
    tooltipEl.style.font = tooltip.options.bodyFont.string;
    tooltipEl.style.padding = tooltip.options.padding + 'px ' + tooltip.options.padding + 'px';
    tooltipEl.style.border = '1px solid #d5d5d5';
};