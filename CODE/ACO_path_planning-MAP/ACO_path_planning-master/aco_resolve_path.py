#!/usr/bin/env python

from map_class import Map
from ant_colony import AntColony
from plot_picture import plot_picture
import time
from conflict_free import do_conflict_free
import copy

# p: is the pheromone's evaporation rate, [0-1]
# Q: is the pheromone adding constant.

if __name__ == '__main__':

    t0 = time.process_time()  #  计时
    ants = 10
    iterations = 20
    p = 0.5
    Q = 1
    display = 1
    map_path = ('XXX.txt')  # 地图文件


    map = Map(map_path)    # Get the map

    if len(map.initial_node) > 1:  # 判断是否是多个个体出发点，各自对应一个地图
        M = []                     # 拆分地图
        n = len(map.initial_node)
        for i in range(n):
            robot = copy.deepcopy(map)
            robot.initial_node = tuple(robot.initial_node[i])
            robot.final_node = tuple(robot.final_node[i])
            M.append(robot)  # map {list:2} Map0 and Map1
        l = len(M)  # a=2
        route = []  #存储所有路径

        #分别生成信息素矩阵
        for i in range(l):
            w = copy.deepcopy(M[i])
            w.nodes_array = w._create_nodes()# 地图中各个点可以走一步到达的位置集合，并记录概率和信息素
            Colony = AntColony(w, ants, iterations, p, Q)
            path = Colony.calculate_path() # 生成路径
            route.append(path)
            print(path)
    print(route)

# 检查是否有冲突出现 并  解决冲突
    route_sort = do_conflict_free(tuple_to_list(route))
    print(route_sort)

# 计时
    t1 = time.process_time()
    time_loss = t1-t0
    print('time loss:{}s'.format(time_loss))

# 画图
    plot_picture(display=1,route=route,n=len(route),map=map)



















