import numpy as np

class Population:

    def __init__(self, pop_size, chromosome_size):
        self.pop_size = pop_size #种群大小
        self.chromosome_size = chromosome_size #染色体长度        
        self.fit_value = np.zeros((self.pop_size, 1))                                      

        
    def fitness(self):
        self.ifpro = np.random.randint(2, size = (self.pop_size, self.chromosome_size)) #初始化染色体， 随机返回范围内的整数 ,数组
        self.fit_value = np.sum(self.ifpro, axis=1)        
        return self.ifpro, self.fit_value   
      
    def select_chromosome(self, elitism_radio): 
		# 精英策略
        elitism_num = int(self.pop_size * elitism_radio)  # 精英策略挑选的染色体数目
        el_index = np.argsort(-self.fit_value)[:elitism_num] #适配度排序，返回索引

      # 轮盘赌法
        roulette_num = self.pop_size - elitism_num  # 轮盘赌法挑选的染色体数目
        rl_index = np.zeros([roulette_num])
        
        fitns_normalized = (np.max(self.fit_value) - self.fit_value) / (np.max(self.fit_value) - np.min(self.fit_value))  # 适应值越小占比越大
        cumsum_prob = np.cumsum(fitns_normalized) / np.sum(fitns_normalized) #cumsum行累加求和        
    
        for i in range(roulette_num):
            for j, j_value in enumerate(cumsum_prob): #遍历找到轮盘赌选择的染色体数目对应的编号
                  if j_value >= np.random.rand(1):
                      rl_index[i] = j
                      break  
        #  整合两者策略挑选的的个体
        select_index = np.hstack((el_index, rl_index)).astype(int) #水平叠加两种方法选择出来的编号 
        new_ifpro = self.ifpro[select_index, :]
        new_fit_value = self.fit_value[select_index]
        self.ifpro = new_ifpro
        self.fit_value = new_fit_value
        return self.ifpro, self.fit_value

    def cross_chromosome(self, cross_rate): #交配算子
        x = self.pop_size
        y = self.chromosome_size
        new_ifpro = np.zeros_like(self.ifpro) #创建一个新数组
        for i in range(0, x-1, 2): #步长为2
            if np.random.rand(1) < cross_rate: #秩为1的数组
                insert_point = int(np.round(np.random.rand(1) * y).item()) #随机一个拼接点；item代表函数以列表返回可遍历的(键, 值) 元组数组  
                new_ifpro[i, :] = np.concatenate([self.ifpro[i, 0:insert_point], self.ifpro[i+1, insert_point:y]], 0) #形成两个新染色体；np.concatenate数组拼接
                new_ifpro[i+1, :] = np.concatenate([self.ifpro[i+1, 0:insert_point], self.ifpro[i, insert_point:y]], 0)
            else:
                new_ifpro[i, :] = self.ifpro[i, :]
                new_ifpro[i + 1, :] = self.ifpro[i + 1, :]
        self.ifpro = new_ifpro
        return self.ifpro

    def mutation_chromosome(self, mutation_rate): #染色体变异
        x = self.pop_size
        for i in range(x):
            if np.random.rand(1) < mutation_rate: #随机一个0到1的浮点数，
                m_point = int(np.round(np.random.rand(1) * self.chromosome_size).item()) #变异点
                if self.ifpro[i, m_point] == 1:
                    self.ifpro[i, m_point] = 0
                else:
                    self.ifpro[i, m_point] = 1
        return self.ifpro

    def best(self): #计算目标值
        individual_best = self.ifpro[0, :]
        best_fit = self.fit_value[0] #第0行的适应度
        for i in range(1, self.pop_size): #判断出最大适应度染色体，以及对应的适应度
            if self.fit_value[i] > best_fit: 
                individual_best = self.ifpro[i, :]
                best_fit = self.fit_value[i]
        return individual_best, best_fit                                

if __name__ == "__main__":
    point = np.random.rand(10, 1) #返回10行1列的服从0-1均匀分布的随机样本
    point = np.sort(point, 0) #给定数组元素进行排序
    print(point)