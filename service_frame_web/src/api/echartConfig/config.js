

export let diskpie = (result) => {
  let option = {
    title: {
      text: ""+result.name+"盘",
      subtext: "总:"+result.total+"G",
      left: 'center'
    },
    tooltip: {
      trigger: 'item'
    },
    series: [
      {
        name: ""+result.name+"盘",
        type: 'pie',
        radius: '50%',
        data: [
          { value: result.available, name: '可用' },
          { value: result.used, name: '已使用' }
        ],
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        }
      }
    ],
    color:['#ccc', '#5470c6'],
  };
  return option;
}
